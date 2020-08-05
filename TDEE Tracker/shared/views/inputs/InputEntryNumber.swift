//
//  InputEntryNumber.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct InputEntryNumberStyle {
    
    // MARK: - Sizes
    
    public let inputTPadding: CGFloat = 8
    public let inputWidth: CGFloat = 140
    public let inputHeight: CGFloat = 44    // SE = 30 + 8
    
    public let iconSize: CGFloat = 30
    
    public let unitWidth: CGFloat = 65
    
    public let bodyPadding: CGFloat = 1
    public let bodyHPadding: CGFloat = 7
    
    public let bodyVPadding: CGFloat
    public let bodyVPaddingOpenOffset: CGFloat
    
    // MARK: - Fonts

    public let valueFont: Font = .custom(FontOswald.Bold, size: 36) // SE = size: 30
    public let unitFont: Font = .custom(FontOswald.Light, size: 24) // SE = size: 30 - 12

    // MARK: - Init

    init(uiSizes: UISizes) {
        
        self.bodyVPadding = uiSizes.entryInputPadding
        self.bodyVPaddingOpenOffset = uiSizes.entryOpenInputOffset
    }
}


struct InputEntryNumber: View {
    
    private let style: InputEntryNumberStyle = InputEntryNumberStyle(uiSizes: UISizes.current)
    
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
                ? self.style.bodyVPadding + self.style.bodyVPaddingOpenOffset
                : self.style.bodyVPadding
        )

        let isEmptyInput = NumberFormatter().number(from: value.wrappedValue) == nil
        let baseColor = ( isEmptyInput ? accentAlternativeColor : accentColor )
        
        
        return HStack(alignment: .center, spacing: 0) {

            CustomImage(
                name: icon,
                colorName: isEmptyInput ? accentAlternativeColorName : accentColorName
            )
                .frame(width: self.style.iconSize, height: self.style.iconSize)
                .padding(.horizontal)

            TextField("", text: value, onCommit: onCommit)
                .font(self.style.valueFont)
                .padding(.trailing, self.style.inputTPadding)
                .frame(width: self.style.inputWidth, height: self.style.inputHeight)
                .multilineTextAlignment(.trailing)
                .border(baseColor)
                .foregroundColor(baseColor)
                .padding(.horizontal)
                .keyboardType(.decimalPad)
                .onTapGesture(perform: openInput)
            
            Text(unit)
                .font(self.style.unitFont)
                .padding(.trailing)
                .frame(width: self.style.unitWidth, alignment: .leading)
                .foregroundColor(baseColor)
        }
            .frame(maxWidth: .infinity)
            .padding(.vertical, bodyVPadding)
            .background(self.backgroundColor)
            .padding(self.style.bodyPadding)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
            .padding(.horizontal, self.style.bodyHPadding)
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
