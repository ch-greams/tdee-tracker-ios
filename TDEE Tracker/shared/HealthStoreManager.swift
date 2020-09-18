//
//  HealthStoreManager.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 9/6/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import HealthKit

class HealthStoreManager {
    
    private static let healthStore: HKHealthStore = HKHealthStore()

    public static var appState: AppState?

    public static let WEIGHT_ID: HKQuantityTypeIdentifier = .bodyMass
    public static let ENERGY_ID: HKQuantityTypeIdentifier = .dietaryEnergyConsumed
    
    public static let AMOUNT_OF_PREVIOUS_DAYS: Int = -28
    
    public static var weightEntries: [ Date : Double ] = [:]
    public static var energyEntries: [ Date : Int ] = [:]
    
    private static var dateRange: (startDate: Date, endDate: Date) {
        
        let currentDate = Date()
        let startDate = currentDate.addDays( HealthStoreManager.AMOUNT_OF_PREVIOUS_DAYS )?.withoutTime ?? currentDate
        
        return ( startDate: startDate, endDate: currentDate )
    }

    
    private static func onAuthCompletion(_ success: Bool, _ error: Error?) {

        if success {
            
            HealthStoreManager.fetchWeightData()
            HealthStoreManager.fetchEnergyData()
        }
        else {
            
            if let appState = HealthStoreManager.appState {
                appState.areWeightEntriesLoaded = true
                appState.areEnergyEntriesLoaded = true
            }
            
            Utils.log(
                source: "HealthStoreManager.onAuthCompletion",
                message: String(error?.localizedDescription ?? "undefined")
            )
        }
    }
    
    public static func requestPermissionsAndFetchHealthData() {
        
        if let appState = HealthStoreManager.appState {
            appState.areWeightEntriesLoaded = false
            appState.areEnergyEntriesLoaded = false
        }
        
        if HKHealthStore.isHealthDataAvailable() {
            
            guard let weightQuantityType = HKQuantityType.quantityType(forIdentifier: Self.WEIGHT_ID),
                  let energyQuantityType = HKQuantityType.quantityType(forIdentifier: Self.ENERGY_ID) else { return }
            
            HealthStoreManager.healthStore.requestAuthorization(
                toShare: [ weightQuantityType, energyQuantityType ],
                read: [ weightQuantityType, energyQuantityType ],
                completion: HealthStoreManager.onAuthCompletion
            )
        }
    }
    
    
    private static func weightRequestHandler(query: HKSampleQuery, results: [ HKSample ]?, error: Error?) {
        
        if let weightSamples = results as? [ HKQuantitySample ] {
            
            let weightEntriesList = weightSamples
                .compactMap {
                    (
                        date: $0.startDate.withoutTime,
                        weight: ( $0.quantity.doubleValue(for: HKUnit.gram()) / 1000 ).rounded(to: 2)
                    )
                }
            
            // NOTE: Saves lowest weight
            HealthStoreManager.weightEntries = Dictionary(weightEntriesList) { old, new in ( old > new ? new : old ) }
        }

        if let appState = HealthStoreManager.appState {
            appState.areWeightEntriesLoaded = true
        }
    }
    
    private static func energyRequestHandler(query: HKSampleQuery, results: [ HKSample ]?, error: Error?) {
        
        if let energySamples = results as? [ HKQuantitySample ] {
            
            let energyEntriesList = energySamples
                .compactMap {
                    (
                        date: $0.startDate.withoutTime,
                        energy: Int( $0.quantity.doubleValue(for: HKUnit.kilocalorie()) )
                    )
                }
            
            // NOTE: Sum of all dietary energy entries
            HealthStoreManager.energyEntries = Dictionary(energyEntriesList) { first, last in ( last + first ) }
        }
        
        if let appState = HealthStoreManager.appState {
            appState.areEnergyEntriesLoaded = true
        }
    }
    
    private static func getHKSampleQuery(
        sampleType: HKSampleType,
        dateRange: (startDate: Date, endDate: Date),
        resultsHandler: @escaping (HKSampleQuery, [ HKSample ]?, Error?) -> Void
    ) -> HKSampleQuery {
        
        let predicate = HKQuery.predicateForSamples(
            withStart: dateRange.startDate,
            end: dateRange.endDate,
            options: .strictStartDate
        )
        
        return HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: HKObjectQueryNoLimit,
            sortDescriptors: nil,
            resultsHandler: resultsHandler
        )
    }
    
    
    public static func fetchWeightData() {

        guard let weightQuantityType = HKQuantityType.quantityType(forIdentifier: Self.WEIGHT_ID) else { return }
        
        HealthStoreManager.healthStore.execute(
            HealthStoreManager.getHKSampleQuery(
                sampleType: weightQuantityType,
                dateRange: HealthStoreManager.dateRange,
                resultsHandler: HealthStoreManager.weightRequestHandler
            )
        )
    }
    
    public static func fetchEnergyData() {
        
        guard let energyQuantityType = HKQuantityType.quantityType(forIdentifier: Self.ENERGY_ID) else { return }
        
        HealthStoreManager.healthStore.execute(
            HealthStoreManager.getHKSampleQuery(
                sampleType: energyQuantityType,
                dateRange: HealthStoreManager.dateRange,
                resultsHandler: HealthStoreManager.energyRequestHandler
            )
        )
    }
    
    private static func fetchDayDataForType(
        quantityType: HKQuantityType,
        day: Date,
        callback: @escaping (HKSampleQuery, [ HKSample ]?, Error?) -> Void
    ) {
        
        if let endDate = day.withoutTime.addDays(1) {
            
            HealthStoreManager.healthStore.execute(
                HealthStoreManager.getHKSampleQuery(
                    sampleType: quantityType,
                    dateRange: ( day.withoutTime, endDate ),
                    resultsHandler: callback
                )
            )
        }
    }
    
    
    private static func getCallbackWithInsertRequest(
        quantityType: HKQuantityType,
        date: Date,
        quantity: HKQuantity?
    ) -> (Bool, Error?) -> Void {

        return { success, error in

            if !success {
                
                // error example: cannot be empty
                Utils.log(
                    source: "HealthStoreManager.callbackWithInsertRequest",
                    message: String(error?.localizedDescription ?? "undefined")
                )
            }
            else if let quantity = quantity {
                
                HealthStoreManager.insertQuantitySample(
                    quantityType: quantityType,
                    date: date,
                    quantity: quantity,
                    callback: HealthStoreManager.insertQuantitySampleCallback
                )
            }
        }
    }
    
    private static func getCallbackWithDeleteRequest(
        quantityType: HKQuantityType,
        date: Date,
        quantity: HKQuantity?
    ) -> (HKSampleQuery, [ HKSample ]?, Error?) -> Void {
        
        return { query, results, error in
            
            if let samples = results as? [ HKQuantitySample ] {
                
                let samplesByApp = samples.filter { $0.sourceRevision.source.name == "TDEE Tracker" }
                
                if samplesByApp.count > 0 {
                    
                    HealthStoreManager.healthStore.delete(
                        samplesByApp,
                        withCompletion: HealthStoreManager.getCallbackWithInsertRequest(
                            quantityType: quantityType,
                            date: date,
                            quantity: quantity
                        )
                    )
                }
                else if let quantity = quantity {
                    
                    HealthStoreManager.insertQuantitySample(
                        quantityType: quantityType,
                        date: date,
                        quantity: quantity,
                        callback: HealthStoreManager.insertQuantitySampleCallback
                    )
                }
            }
        }
    }
    

    private static func insertQuantitySampleCallback(_ success: Bool, _ error: Error?) {
        
        if !success {
            
            Utils.log(
                source: "HealthStoreManager.insertQuantitySampleCallback",
                message: String(error?.localizedDescription ?? "undefined")
            )
        }
    }
    
    
    
    private static func insertQuantitySample(
        quantityType: HKQuantityType,
        date: Date,
        quantity: HKQuantity,
        callback: @escaping (Bool, Error?) -> Void
    ) {
        
        let quantitySample = HKQuantitySample(
            type: quantityType,
            quantity: quantity,
            start: date, end: date
        )
        
        HealthStoreManager.healthStore.save(
            quantitySample,
            withCompletion: callback
        )
    }
    
    private static func getHKQuantityByType(
        quantityTypeIdentifier: HKQuantityTypeIdentifier,
        value: Double
    ) -> HKQuantity? {
        
        switch quantityTypeIdentifier {

            case HKQuantityTypeIdentifier.bodyMass:
                return HKQuantity(unit: .gram(), doubleValue: value * 1000)
            case HKQuantityTypeIdentifier.dietaryEnergyConsumed:
                return HKQuantity(unit: .kilocalorie(), doubleValue: value)
            default:
                return nil
        }
    }
    
    public static func addEntry(
        type: HKQuantityTypeIdentifier,
        date: Date,
        value: Double?
    ) {
        
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: type) else { return }
        
        let quantity = value.flatMap {
            HealthStoreManager.getHKQuantityByType(quantityTypeIdentifier: type, value: $0)
        }
        
        HealthStoreManager.fetchDayDataForType(
            quantityType: quantityType,
            day: date,
            callback: HealthStoreManager.getCallbackWithDeleteRequest(
                quantityType: quantityType,
                date: date,
                quantity: quantity
            )
        )
    }
}
