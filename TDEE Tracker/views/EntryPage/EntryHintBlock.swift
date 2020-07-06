//
//  RecommendedAmountBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct EntryHintBlock: View {
    
    let isEnoughData: Bool

    let value: Int
    let unit: String
    
    let textColor: Color

    init(
        value: Int,
        unit: String,
        textColor: Color,
        isEnoughData: Bool = true
    ) {
        self.value = value
        self.unit = unit
        
        self.textColor = textColor

        self.isEnoughData = isEnoughData
    }
    
    func getTextBlock(hint: String) -> some View {
        
        HStack {

            Text(hint.uppercased())
                .multilineTextAlignment(.center)
                .frame(minHeight: 46, maxHeight: 60)
                .foregroundColor(self.textColor)
                .font(.appEntryRecommendedLabel)

        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 36.0)
    }
    
    var defaultBlock: some View {
        HStack(alignment: .center, spacing: 0) {

            Text(Label.recommendedAmount.uppercased())
                .multilineTextAlignment(.center)
                .frame(width: 84)
                .foregroundColor(self.textColor)
                .font(.appEntryRecommendedLabel)
            
            Text("~\(self.value)")
                .frame(width: 154, alignment: .trailing)
                .foregroundColor(self.textColor)
                .font(.appEntryRecommendedAmount)
                .padding(.trailing, 10)
            
            Text(self.unit)
                .foregroundColor(self.textColor)
                .font(.appEntryUnit)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 36.0)
    }
    
    var body: some View {
        
        ZStack {

            if self.isEnoughData && self.value > 0 {

                self.defaultBlock
            }
            else {

                self.getTextBlock(hint: Label.notEnoughDataHint)
            }
        }
    }
}

struct EntryHintBlock_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            EntryHintBlock(
                value: 2843,
                unit: EnergyUnit.kcal.localized,
                textColor: UIThemeManager.DEFAULT.mainTextColor,
                isEnoughData: false
            )
                .background(UIThemeManager.DEFAULT.backgroundColor)
            
            EntryHintBlock(
                value: 2843,
                unit: EnergyUnit.kcal.localized,
                textColor: UIThemeManager.DEFAULT.mainTextColor
            )
                .background(UIThemeManager.DEFAULT.backgroundColor)
        }
    }
}
