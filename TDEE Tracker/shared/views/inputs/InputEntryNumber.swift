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
    
    public let inputTPadding: CGFloat = 8
    public let inputWidth: CGFloat = 140
    public let inputFontTPadding: CGFloat = -2
    
    public let unitWidth: CGFloat = 65
    
    public let bodyPadding: CGFloat = 1
    public let bodyHPadding: CGFloat = 7
    
    public let inputHeight: CGFloat
    public let iconSize: CGFloat
    
    public let bodyVPadding: CGFloat
    
    // MARK: - Fonts

    public let valueFont: Font
    public let unitFont: Font

    // MARK: - Init

    init(uiSizes: UISizes) {
        
        self.bodyVPadding = uiSizes.entryInputPadding
        
        self.inputHeight = uiSizes.entryInputBaseSize + 8
        self.iconSize = uiSizes.entryInputBaseSize - 4
        self.valueFont = .custom(FontOswald.Bold, size: uiSizes.entryInputBaseSize)
        self.unitFont = .custom(FontOswald.Light, size: uiSizes.entryInputBaseSize - 12)
    }
}


struct InputEntryNumber: View {
    
    private let sizes = InputEntryNumberSizes(uiSizes: UISizes.current)
    
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
