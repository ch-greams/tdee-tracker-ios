//
//  RecommendedAmountBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct EntryHintBlockSizes {
    
    // MARK: - Sizes
    
    public let hintMinHeight: CGFloat = 46
    public let hintMaxHeight: CGFloat = 60
    
    public let recommendedAmountValueTPadding: CGFloat = 10
    
    public let recommendedAmountHPadding: CGFloat
    
    // MARK: - Fonts

    public let recommendedValue: Font = .custom(FontOswald.Bold, size: 32)
    public let recommendedUnit: Font = .custom(FontOswald.Light, size: 24)
    
    public let hintLabelFont: Font
    public let recommendedLabelFont: Font
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.recommendedAmountHPadding = uiSizes.entryHintHPadding
        
        self.hintLabelFont = .custom(FontOswald.Light, size: uiSizes.entryHintFontSize)
        self.recommendedLabelFont = .custom(FontOswald.Light, size: uiSizes.entryHintLabelFontSize)
    }
}


struct EntryHintBlock: View {
    
    private let sizes = EntryHintBlockSizes(uiSizes: UISizes.current)
    
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
                .frame(minHeight: self.sizes.hintMinHeight, maxHeight: self.sizes.hintMaxHeight)
                .foregroundColor(self.textColor)
                .font(self.sizes.hintLabelFont)
        }
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var defaultBlock: some View {
        HStack(alignment: .center, spacing: 0) {

            Text(Label.recommendedAmount.uppercased())
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(self.textColor)
                .font(self.sizes.recommendedLabelFont)
            
            Text(String(self.value))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(self.textColor)
                .font(self.sizes.recommendedValue)
                .padding(.trailing, self.sizes.recommendedAmountValueTPadding)
            
            Text(self.unit)
                .foregroundColor(self.textColor)
                .font(self.sizes.recommendedUnit)
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: self.sizes.hintMinHeight, maxHeight: self.sizes.hintMaxHeight)
            .padding(.horizontal, self.sizes.recommendedAmountHPadding)
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
