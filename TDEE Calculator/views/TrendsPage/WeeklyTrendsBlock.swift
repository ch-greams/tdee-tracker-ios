//
//  WeeklyTrendsBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct WeeklyTrendsBlock: View {
    
    let weightUnitLabel: String
    let energyUnitLabel: String
    
    let selectedDay: Date
    
    let summary: WeekSummary
    
    let trendsChange: (
        avgFood: WeekSummaryChange,
        avgWeight: WeekSummaryChange,
        deltaWeight: WeekSummaryChange,
        tdee: WeekSummaryChange
    )
    
    func getChangeIcon(change: WeekSummaryChange) -> String {
        
        switch change {
            case WeekSummaryChange.Up:
                return "chevron.up"
            case WeekSummaryChange.Down:
                return "chevron.down"
            default:
                return "ellipsis"
        }
    }

    func getLine(label: String, value: String, unit: String, changeIcon: String) -> some View {
        
        return HStack(alignment: .center, spacing: 0) {
        
            Text(label)
                .font(.appTrendsItemLabel)
                .foregroundColor(.appPrimary)
                .frame(width: 120, alignment: .leading)
                .padding(.leading, 30)
                .padding(.trailing, 10)
            
            Text(value)
                .font(.appTrendsItemValue)
                .foregroundColor(.appPrimary)
                .frame(width: 92, alignment: .trailing)
                .padding(.trailing, 10)

            Text(unit)
                .font(.appTrendsItemUnit)
                .foregroundColor(.appPrimary)
                .frame(width: 30, alignment: .leading)
                .padding(.trailing, 10)

            Image(systemName: changeIcon)
                .foregroundColor(.appPrimary)
                .frame(width: 16)
                .padding(.trailing, 30)
        }
        .frame(height: 64)
    }
    
    var separator: some View {
        return Rectangle()
            .foregroundColor(.appPrimaryTextLight)
            .frame(height: 1)
            .padding(.horizontal, 16)
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {

            // TODO: Use ForEach?
            
            self.getLine(
                label: "FOOD",
                value: String(self.summary.avgFood ?? 0),
                unit: self.energyUnitLabel.uppercased(),
                changeIcon: self.getChangeIcon(change: self.trendsChange.avgFood)
            )
            
            self.separator
            
            self.getLine(
                label: "WEIGHT",
                value: String(format: "%.2f", self.summary.avgWeight),
                unit: self.weightUnitLabel.uppercased(),
                changeIcon: self.getChangeIcon(change: self.trendsChange.avgWeight)
            )
            
            self.separator
            
            self.getLine(
                label: "TDEE",
                value: String(self.summary.tdee ?? 0),
                unit: self.energyUnitLabel.uppercased(),
                changeIcon: self.getChangeIcon(change: self.trendsChange.tdee)
            )
            
            self.separator
            
            self.getLine(
                label: "WEIGHT CHANGE",
                value: String(format: "%.2f", self.summary.deltaWeight ?? 0),
                unit: self.weightUnitLabel.uppercased(),
                changeIcon: self.getChangeIcon(change: self.trendsChange.deltaWeight)
            )
            
        }
            .frame(width: 358, height: 280)
            .background(Color(.white))
            .padding(8)
            .clipped()
            .shadow(color: .gray, radius: 1, x: 1, y: 1)
    }
}

struct WeeklyTrendsBlock_Previews: PreviewProvider {
    
    static let summary = WeekSummary(avgFood: 2800, avgWeight: 76.50, deltaWeight: -0.75, tdee: 2845)
    
    static var previews: some View {
        WeeklyTrendsBlock(
            weightUnitLabel: "kg",
            energyUnitLabel: "kcal",
            selectedDay: Date(),
            summary: summary,
            trendsChange: (
                avgFood: WeekSummaryChange.Up,
                avgWeight: WeekSummaryChange.Down,
                deltaWeight: WeekSummaryChange.Down,
                tdee: WeekSummaryChange.Up
            )
        )
            .background(Color.appPrimary)
    }
}
