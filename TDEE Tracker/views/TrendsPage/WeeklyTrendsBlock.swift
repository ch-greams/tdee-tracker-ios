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
    
    let backgroundColor: Color
    let accentColor: Color
    let textColor: Color

    // TODO: Check alternative for icons
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
                .frame(width: 132, alignment: .leading)
                .padding(.horizontal)
            
            Text(data.value)
                .font(.appTrendsItemValue(self.trendsItemValueFontSize))
                .frame(minWidth: 80, alignment: .trailing)

            Text(data.unit)
                .font(.appTrendsItemUnit(self.trendsItemUnitFontSize))
                .frame(width: 30, alignment: .leading)
                .padding(.horizontal)

            Image(systemName: self.getChangeIcon(change: data.changeType))
                .frame(width: 16)
                .padding(.trailing)
        }
            .foregroundColor(self.textColor)
            .padding(.vertical, self.trendsElementPadding)
    }
    
    var separator: some View {
        return Rectangle()
            .foregroundColor(self.accentColor)
            .frame(height: 1)
            .padding(.horizontal, 16)
    }
    
    var body: some View {

        let lines = [
            LineData(
                label: Label.food.uppercased(),
                value: self.summary.avgFood.map { $0 < 0 ? "0" : String($0) } ?? "0",
                unit: self.energyUnitLabel,
                changeType: self.trendsChange.avgFood
            ),
            LineData(
                label: Label.weight.uppercased(),
                value: String(format: "%.2f", self.summary.avgWeight < 0 ? 0 : self.summary.avgWeight),
                unit: self.weightUnitLabel,
                changeType: self.trendsChange.avgWeight
            ),
            LineData(
                label: Label.tdee.uppercased(),
                value: self.summary.tdee.map { $0 < 0 ? "0" : String($0) } ?? "0",
                unit: self.energyUnitLabel,
                changeType: self.trendsChange.tdee
            ),
            LineData(
                label: Label.weightChange.uppercased(),
                value: String(format: "%.2f", self.summary.deltaWeight ?? 0),
                unit: self.weightUnitLabel,
                changeType: self.trendsChange.deltaWeight
            )
        ]
        
        return VStack(alignment: .center, spacing: 0) {
            
            ForEach(0 ..< lines.count) { i in
                
                VStack(alignment: .center, spacing: 0) {

                    if i > 0 {
                        self.separator
                    }

                    self.getLine(data: lines[i])
                }
            }
        }
            .padding(.vertical, self.trendsElementPadding)
            .background(self.backgroundColor)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
    }
}

struct WeeklyTrendsBlock_Previews: PreviewProvider {
    
    static let summary = WeekSummary(avgFood: 2800, avgWeight: 76.50, deltaWeight: -0.75, tdee: 2845)
    
    static var previews: some View {
        WeeklyTrendsBlock(
            weightUnitLabel: WeightUnit.kg.localized,
            energyUnitLabel: EnergyUnit.kcal.localized,
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
            trendsItemUnitFontSize: 14,
            backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
            accentColor: UIThemeManager.DEFAULT.trendsSeparatorColor,
            textColor: UIThemeManager.DEFAULT.secondaryTextColor
        )
            .padding(.vertical, 8)
            .background(UIThemeManager.DEFAULT.backgroundColor)
            
    }
}
