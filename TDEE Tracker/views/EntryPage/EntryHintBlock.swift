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
    
    public let hintMinHeight: CGFloat
    public let hintMaxHeight: CGFloat
    
    public let recommendedAmountValueTPadding: CGFloat
    
    public let recommendedAmountHPadding: CGFloat
    
    // MARK: - Fonts

    public let recommendedValue: Font
    public let recommendedUnit: Font
    
    public let hintLabelFont: Font
    public let recommendedLabelFont: Font
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.hintMinHeight = scale * 46
        self.hintMaxHeight = scale * 60
    
        self.recommendedAmountValueTPadding = scale * 10

        self.recommendedValue = .custom(FontOswald.Bold, size: scale * 32)
        self.recommendedUnit = .custom(FontOswald.Light, size: scale * 24)

        if hasNotch {
            self.recommendedAmountHPadding = scale * 30
            
            self.hintLabelFont = .custom(FontOswald.Light, size: scale * 17)
            self.recommendedLabelFont = .custom(FontOswald.Light, size: scale * 15)
        }
        else {
            self.recommendedAmountHPadding = scale * 28
            
            self.hintLabelFont = .custom(FontOswald.Light, size: scale * 14)
            self.recommendedLabelFont = .custom(FontOswald.Light, size: scale * 12)
        }
    }
}


struct EntryHintBlock: View {
    
    private let sizes = EntryHintBlockSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
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
