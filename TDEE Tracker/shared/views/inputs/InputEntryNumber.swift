//
//  InputEntryNumber.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct InputEntryNumberSizes {
    
    // MARK: - Sizes
    
    public let inputTPadding: CGFloat
    public let inputWidth: CGFloat
    public let inputFontTPadding: CGFloat
    
    public let unitWidth: CGFloat
    
    public let bodyPadding: CGFloat
    public let bodyHPadding: CGFloat
    
    public let inputHeight: CGFloat
    public let iconSize: CGFloat
    
    public let bodyVPadding: CGFloat
    
    // MARK: - Fonts

    public let valueFont: Font
    public let unitFont: Font

    // MARK: - Init

    init(hasNotch: Bool, scale: CGFloat) {
        
        self.inputTPadding = scale * 8
        self.inputWidth = scale * 140
        self.inputFontTPadding = scale * -2
    
        self.unitWidth = scale * 65
    
        self.bodyPadding = scale * 1
        self.bodyHPadding = 7

        if hasNotch {
            self.bodyVPadding = scale * 27
            
            self.inputHeight = scale * 36 + 8
            self.iconSize = scale * 36 - 4
            self.valueFont = .custom(FontOswald.Bold, size: scale * 36)
            self.unitFont = .custom(FontOswald.Light, size: scale * 36 - 12)
        }
        else {
            self.bodyVPadding = scale * 14
            
            self.inputHeight = scale * 30 + 8
            self.iconSize = scale * 30 - 4
            self.valueFont = .custom(FontOswald.Bold, size: scale * 30)
            self.unitFont = .custom(FontOswald.Light, size: scale * 30 - 12)
        }
    }
}


struct InputEntryNumber: View {
    
    private let sizes = InputEntryNumberSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    let icon: String
    let unit: String
    let value: Binding<String>
    let openInput: () -> Void
    let isSelected: Bool
    
    let backgroundColor: Color
    let backgroundSelectedColor: Color
    
    let accentColor: Color
    let accentColorName: String
    let accentAlternativeColor: Color
    let accentAlternativeColorName: String
    
    var body: some View {

        let isEmptyInput = NumberFormatter().number(from: self.value.wrappedValue) == nil
        let baseColor = ( isEmptyInput ? self.accentAlternativeColor : self.accentColor )
        
        
        return HStack(alignment: .center, spacing: 0) {

            CustomImage(
                name: icon,
                colorName: isEmptyInput ? self.accentAlternativeColorName : self.accentColorName
            )
                .frame(width: self.sizes.iconSize, height: self.sizes.iconSize)
                .frame(maxWidth: .infinity, alignment: .trailing)

            Text(self.value.wrappedValue)
                .font(self.sizes.valueFont)
                .padding(.top, self.sizes.inputFontTPadding)
                .padding(.trailing, self.sizes.inputTPadding)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(width: self.sizes.inputWidth, height: self.sizes.inputHeight, alignment: .trailing)
                .background(self.isSelected ? self.backgroundSelectedColor : self.backgroundColor)
                .border(baseColor)
                .foregroundColor(baseColor)
                .padding(.horizontal)
            
            Text(self.unit)
                .font(self.sizes.unitFont)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(baseColor)
        }
            .frame(maxWidth: .infinity)
            .padding(.vertical, self.sizes.bodyVPadding)
            .background(self.backgroundColor)
            .padding(self.sizes.bodyPadding)
            .clipped()
            .onTapGesture(perform: self.openInput)
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
            .padding(.horizontal, self.sizes.bodyHPadding)
    }
}


struct InputEntryNumber_Previews: PreviewProvider {

    static var previews: some View {
        
        ZStack {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 8) {
                
                InputEntryNumber(
                    icon: "body-sharp",
                    unit: WeightUnit.kg.localized,
                    value: .constant("71.5"),
                    openInput: { print("openInput") },
                    isSelected: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundSelectedColor: UIThemeManager.DEFAULT.calendarWeekHighlight,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    accentAlternativeColor: UIThemeManager.DEFAULT.inputAccentAlternativeColor,
                    accentAlternativeColorName: UIThemeManager.DEFAULT.inputAccentAlternativeColorName
                )
                
                InputEntryNumber(
                    icon: "body-sharp",
                    unit: WeightUnit.kg.localized,
                    value: .constant(""),
                    openInput: { print("openInput") },
                    isSelected: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundSelectedColor: UIThemeManager.DEFAULT.calendarWeekHighlight,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    accentAlternativeColor: UIThemeManager.DEFAULT.inputAccentAlternativeColor,
                    accentAlternativeColorName: UIThemeManager.DEFAULT.inputAccentAlternativeColorName
                )
                
                InputEntryNumber(
                    icon: "fast-food-sharp",
                    unit: EnergyUnit.kcal.localized,
                    value: .constant("2934"),
                    openInput: { print("openInput") },
                    isSelected: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundSelectedColor: UIThemeManager.DEFAULT.calendarWeekHighlight,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    accentAlternativeColor: UIThemeManager.DEFAULT.inputAccentAlternativeColor,
                    accentAlternativeColorName: UIThemeManager.DEFAULT.inputAccentAlternativeColorName
                )
                
                InputEntryNumber(
                    icon: "fast-food-sharp",
                    unit: EnergyUnit.kcal.localized,
                    value: .constant(""),
                    openInput: { print("openInput") },
                    isSelected: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundSelectedColor: UIThemeManager.DEFAULT.calendarWeekHighlight,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    accentAlternativeColor: UIThemeManager.DEFAULT.inputAccentAlternativeColor,
                    accentAlternativeColorName: UIThemeManager.DEFAULT.inputAccentAlternativeColorName
                )
            }
        }
    }
}
