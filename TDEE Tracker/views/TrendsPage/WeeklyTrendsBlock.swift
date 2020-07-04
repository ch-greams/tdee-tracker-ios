//
//  WeeklyTrendsBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct LineData {

    let label: String
    let value: String
    let unit: String
    let changeType: WeekSummaryChange
}

struct WeeklyTrendsBlock: View {
    
    let weightUnitLabel: String
    let energyUnitLabel: String
    
    let selectedDay: Date
    
    let summary: WeekSummary
    
    let trendsChange: WeekSummaryTrends
    
    let trendsElementPadding: CGFloat
    let trendsItemLabelFontSize: CGFloat
    let trendsItemValueFontSize: CGFloat
    let trendsItemUnitFontSize: CGFloat
    
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

    func getLine(data: LineData) -> some View {
        
        return HStack(alignment: .center, spacing: 0) {
        
            Text(data.label)
                .font(.appTrendsItemLabel(self.trendsItemLabelFontSize))
                .foregroundColor(.appPrimary)
                .frame(width: 132, alignment: .leading)
                .padding(.horizontal)
            
            Text(data.value)
                .font(.appTrendsItemValue(self.trendsItemValueFontSize))
                .foregroundColor(.appPrimary)
                .frame(minWidth: 80, alignment: .trailing)

            Text(data.unit.uppercased())
                .font(.appTrendsItemUnit(self.trendsItemUnitFontSize))
                .foregroundColor(.appPrimary)
                .frame(width: 30, alignment: .leading)
                .padding(.horizontal)

            Image(systemName: self.getChangeIcon(change: data.changeType))
                .foregroundColor(.appPrimary)
                .frame(width: 16)
                .padding(.trailing)
        }
            .padding(.vertical, self.trendsElementPadding)
    }
    
    var separator: some View {
        return Rectangle()
            .foregroundColor(.appPrimaryTextLight)
            .frame(height: 1)
            .padding(.horizontal, 16)
    }
    
    var body: some View {

        let lines = [
            LineData(
                label: "FOOD",
                value: self.summary.avgFood.map { $0 < 0 ? "0" : String($0) } ?? "0",
                unit: self.energyUnitLabel,
                changeType: self.trendsChange.avgFood
            ),
            LineData(
                label: "WEIGHT",
                value: String(format: "%.2f", self.summary.avgWeight < 0 ? 0 : self.summary.avgWeight),
                unit: self.weightUnitLabel,
                changeType: self.trendsChange.avgWeight
            ),
            LineData(
                label: "TDEE",
                value: self.summary.tdee.map { $0 < 0 ? "0" : String($0) } ?? "0",
                unit: self.energyUnitLabel,
                changeType: self.trendsChange.tdee
            ),
            LineData(
                label: "WEIGHT CHANGE",
                value: String(format: "%.2f", self.summary.deltaWeight ?? 0),
                unit: self.weightUnitLabel,
                changeType: self.trendsChange.deltaWeight
            )
        ]
        
        return VStack(alignment: .center, spacing: 0) {
            
            ForEach(lines, id: \.label) { lineData in
                
                VStack(alignment: .center, spacing: 0) {

                    if lineData.label != lines[0].label {
                        self.separator
                    }

                    self.getLine(data: lineData)
                }
            }
        }
            .padding(.vertical, self.trendsElementPadding)
            .background(Color.appWhite)
            .padding(.horizontal, 8)
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
            trendsChange: WeekSummaryTrends(
                avgFood: WeekSummaryChange.Up,
                avgWeight: WeekSummaryChange.Down,
                deltaWeight: WeekSummaryChange.Down,
                tdee: WeekSummaryChange.Up
            ),
            trendsElementPadding: 10,
            trendsItemLabelFontSize: 18,
            trendsItemValueFontSize: 32,
            trendsItemUnitFontSize: 14
        )
            .padding(.vertical, 8)
            .background(Color.appPrimary)
            
    }
}
