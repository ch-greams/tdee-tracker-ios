//
//  EntryPage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct EntryPage: View {

    @EnvironmentObject var appState: AppState

    @State private var isWeightInputOpen: Bool = false
    @State private var isFoodInputOpen: Bool = false

    func updateWeightFunc() {
    
        if let value = NumberFormatter().number(from: self.appState.weightInput) {
            self.appState.weight = value.doubleValue
        }
        
        self.appState.updateWeightInEntry()
        self.appState.refreshGoalBasedValues()
        
        self.appState.weightInput = String(self.appState.weight)
    }
    
    func updateFoodFunc() {
    
        if let value = NumberFormatter().number(from: self.appState.foodInput) {
            self.appState.food = value.intValue
        }
        
        self.appState.updateFoodInEntry()
        self.appState.refreshGoalBasedValues()
        
        self.appState.foodInput = String(self.appState.food)
    }
    
    
    func onSubmit() {

        UIApplication.shared.endEditing()
        
        if self.isWeightInputOpen {
            
            self.updateWeightFunc()
            self.isWeightInputOpen = false
        }
        
        if self.isFoodInputOpen {
            
            self.updateFoodFunc()
            self.isFoodInputOpen = false
        }
    }
    
    
    var body: some View {
        
        return ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {

                // TODO: Drop selectedDay param altogether?
                CalendarBlock(selectedDay: self.appState.selectedDay, isTrendsPage: false)
                
                RecAmountBlock(value: self.appState.recommendedAmount)
            }
            
            if self.isWeightInputOpen || self.isFoodInputOpen {
                Color.appFade.edgesIgnoringSafeArea(.all)
                    .onTapGesture(perform: self.onSubmit)
                    .zIndex(1)
            }


            EntryInputBlock(
                value: self.$appState.weightInput,
                onCommit: self.onSubmit,
                icon: "body-sharp",
                unit: "kg"
            )
                .padding(.horizontal, 7)
                .animation(.easeOut(duration: 0.16))
                .padding(.top, self.isWeightInputOpen ? 160 : 458)
                .onTapGesture { self.isWeightInputOpen = true }
                .zIndex(self.isWeightInputOpen ? 1 : 0)

            EntryInputBlock(
                value: self.$appState.foodInput,
                onCommit: self.onSubmit,
                icon: "fast-food-sharp",
                unit: "kcal"
            )
                .padding(.horizontal, 7)
                .animation(.easeOut(duration: 0.16))
                .padding(.top, self.isFoodInputOpen ? 160 : 562)
                .onTapGesture { self.isFoodInputOpen = true }
                .zIndex(self.isFoodInputOpen ? 1 : 0)
                
        }


    }
}

struct EntryPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        EntryPage().environmentObject(appState)
    }
}
