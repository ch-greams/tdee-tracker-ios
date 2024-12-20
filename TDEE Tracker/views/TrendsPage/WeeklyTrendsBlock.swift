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


struct WeeklyTrendsBlockSizes {
    
    // MARK: - Sizes
    
    public let trendsItemValueMinWidth: CGFloat
    public let trendsItemUnitWidth: CGFloat
    
    public let trendsItemChangeIconWidth: CGFloat
    public let trendsItemChangeIconHeight: CGFloat
    
    public let separatorHeight: CGFloat
    public let separatorHPadding: CGFloat
    
    public let trendsItemsHPadding: CGFloat
    public let trendsItemsVPadding: CGFloat
    
    public let trendsItemHPadding: CGFloat
    
    public let trendsItemVPadding: CGFloat
    
    // MARK: - Fonts
    
    public let trendsItemLabelFont: Font
    public let trendsItemValueFont: Font
    public let trendsItemUnitFont: Font
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {

        self.trendsItemValueMinWidth = scale * 80
        self.trendsItemUnitWidth = scale * 34
    
        self.trendsItemChangeIconWidth = scale * 16
        self.trendsItemChangeIconHeight = scale * 22
    
        self.separatorHeight = scale * 1
        self.separatorHPadding = scale * 16
    
        self.trendsItemsHPadding = scale * 8
        self.trendsItemsVPadding = scale * 2
    
        self.trendsItemHPadding = scale * 6

        if hasNotch {
            self.trendsItemVPadding = scale * 10
            
            self.trendsItemLabelFont = .custom(FontOswald.Light, size: scale * 17)
            self.trendsItemValueFont = .custom(FontOswald.Bold, size: scale * 32)
            self.trendsItemUnitFont = .custom(FontOswald.Light, size: scale * 14)
        }
        else {
            self.trendsItemVPadding = scale * 2
            
            self.trendsItemLabelFont = .custom(FontOswald.Light, size: scale * 12)
            self.trendsItemValueFont = .custom(FontOswald.Bold, size: scale * 28)
            self.trendsItemUnitFont = .custom(FontOswald.Light, size: scale * 12)
        }
    }
}


struct WeeklyTrendsBlock: View {
    
    private let sizes = WeeklyTrendsBlockSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    let weightUnitLabel: String
    let energyUnitLabel: String
    
    let selectedDay: Date
    
    let summary: WeekSummary
    
    let trendsChange: WeekSummaryTrends
    
    let backgroundColor: Color
    let accentColor: Color
    let textColor: Color
    let iconColor: String


    func getLine(data: LineData) -> some View {
        
        HStack(alignment: .center, spacing: 0) {
        
            Text(data.label)
                .font(self.sizes.trendsItemLabelFont)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text(data.value)
                .font(self.sizes.trendsItemValueFont)
                .frame(minWidth: self.sizes.trendsItemValueMinWidth, alignment: .trailing)

            Text(data.unit)
                .font(self.sizes.trendsItemUnitFont)
                .frame(width: self.sizes.trendsItemUnitWidth, alignment: .leading)
                .padding(.horizontal)

            CustomImage(name: data.changeType.icon, colorName: self.iconColor)
                .frame(
                    width: self.sizes.trendsItemChangeIconWidth,
                    height: self.sizes.trendsItemChangeIconHeight
                )
                .padding(.trailing)
        }
            .foregroundColor(self.textColor)
            .padding(.vertical, self.sizes.trendsItemVPadding)
            .padding(.horizontal, self.sizes.trendsItemHPadding)
    }
    
    var trendLines: [ LineData ] {
        [
            LineData(
                label: Label.food.uppercased(),
                value: self.summary.avgFood.map { $0 < 0 ? "0" : String($0) } ?? "0",
                unit: self.energyUnitLabel,
                changeType: self.trendsChange.avgFood
            ),
            LineData(
                label: Label.weight.uppercased(),
                value: ( (self.summary.avgWeight < 0) ? 0 : self.summary.avgWeight ).toString(),
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
                value: (self.summary.deltaWeight ?? 0).toString(),
                unit: self.weightUnitLabel,
                changeType: self.trendsChange.deltaWeight
            )
        ]
    }
    
    var separator: some View {
        Rectangle()
            .foregroundColor(self.accentColor)
            .frame(height: self.sizes.separatorHeight)
            .padding(.horizontal, self.sizes.separatorHPadding)
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            ForEach(0 ..< self.trendLines.count) { i in
                
                VStack(alignment: .center, spacing: 0) {

                    if i > 0 {
                        self.separator
                    }

                    self.getLine(data: self.trendLines[i])
                }
            }
        }
            .padding(.vertical, self.sizes.trendsItemsVPadding)
            .background(self.backgroundColor)
            .padding(.horizontal, self.sizes.trendsItemsHPadding)
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
                deltaWeight: WeekSummaryChange.None,
                tdee: WeekSummaryChange.Up
            ),
            backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
            accentColor: UIThemeManager.DEFAULT.trendsSeparatorColor,
            textColor: UIThemeManager.DEFAULT.secondaryTextColor,
            iconColor: UIThemeManager.DEFAULT.secondaryTextColorName
        )
            .padding(.vertical, 8)
            .background(UIThemeManager.DEFAULT.backgroundColor)
            
    }
}
