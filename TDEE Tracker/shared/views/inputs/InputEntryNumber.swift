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
    
    public let unitWidth: CGFloat = 65
    
    public let bodyPadding: CGFloat = 1
    public let bodyHPadding: CGFloat = 7
    
    public let inputHeight: CGFloat
    public let iconSize: CGFloat
    
    public let bodyVPadding: CGFloat
    public let bodyVPaddingOpenOffset: CGFloat
    
    // MARK: - Fonts

    public let valueFont: Font
    public let unitFont: Font

    // MARK: - Init

    init(uiSizes: UISizes) {
        
        self.bodyVPadding = uiSizes.entryInputPadding
        self.bodyVPaddingOpenOffset = uiSizes.entryInputPaddingOpenOffset
        
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
    let onCommit: () -> Void
    let openInput: () -> Void
    let isOpen: Bool
    
    let backgroundColor: Color
    let accentColor: Color
    let accentColorName: String
    let accentAlternativeColor: Color
    let accentAlternativeColorName: String
    
    var body: some View {
        
        let bodyVPadding = (
            self.isOpen
                ? self.sizes.bodyVPadding + self.sizes.bodyVPaddingOpenOffset
                : self.sizes.bodyVPadding
        )

        let isEmptyInput = NumberFormatter().number(from: value.wrappedValue) == nil
        let baseColor = ( isEmptyInput ? accentAlternativeColor : accentColor )
        
        
        return HStack(alignment: .center, spacing: 0) {

            CustomImage(
                name: icon,
                colorName: isEmptyInput ? accentAlternativeColorName : accentColorName
            )
                .frame(width: self.sizes.iconSize, height: self.sizes.iconSize)
                .frame(maxWidth: .infinity, alignment: .trailing)

            TextField("", text: value, onCommit: onCommit)
                .font(self.sizes.valueFont)
                .padding(.trailing, self.sizes.inputTPadding)
                .frame(width: self.sizes.inputWidth, height: self.sizes.inputHeight)
                .multilineTextAlignment(.trailing)
                .border(baseColor)
                .foregroundColor(baseColor)
                .padding(.horizontal)
                .keyboardType(.decimalPad)
                .onTapGesture(perform: openInput)
            
            Text(unit)
                .font(self.sizes.unitFont)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(baseColor)
        }
            .frame(maxWidth: .infinity)
            .padding(.vertical, bodyVPadding)
            .background(self.backgroundColor)
            .padding(self.sizes.bodyPadding)
            .clipped()
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
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    accentAlternativeColor: UIThemeManager.DEFAULT.inputAccentAlternativeColor,
                    accentAlternativeColorName: UIThemeManager.DEFAULT.inputAccentAlternativeColorName
                )
                
                InputEntryNumber(
                    icon: "body-sharp",
                    unit: WeightUnit.kg.localized,
                    value: .constant(""),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    accentAlternativeColor: UIThemeManager.DEFAULT.inputAccentAlternativeColor,
                    accentAlternativeColorName: UIThemeManager.DEFAULT.inputAccentAlternativeColorName
                )
                
                InputEntryNumber(
                    icon: "fast-food-sharp",
                    unit: EnergyUnit.kcal.localized,
                    value: .constant("2934"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    accentAlternativeColor: UIThemeManager.DEFAULT.inputAccentAlternativeColor,
                    accentAlternativeColorName: UIThemeManager.DEFAULT.inputAccentAlternativeColorName
                )
                
                InputEntryNumber(
                    icon: "fast-food-sharp",
                    unit: EnergyUnit.kcal.localized,
                    value: .constant(""),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    accentAlternativeColor: UIThemeManager.DEFAULT.inputAccentAlternativeColor,
                    accentAlternativeColorName: UIThemeManager.DEFAULT.inputAccentAlternativeColorName
                )
            }
        }
    }
}
