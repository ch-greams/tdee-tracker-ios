//
//  InputBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/25/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



class InputBlock {
    
    
    public static func Toggle<T>(
        title: String,
        setValue: @escaping (T) -> Void,
        first: T,
        second: T,
        selected: Optional<T>,
        maxHeight: CGFloat,
        backgroundColor: Color,
        accentColor: Color
    ) -> some View where T:Equatable, T:Localizable {

        let firstButton = Button(
            first.localized,
            action: { setValue(first) }
        )
            .buttonStyle(ToggleButtonStyle(
                isSelected: selected == first,
                backgroundColor: backgroundColor,
                accentColor: accentColor
            ))
        
        let secondButton = Button(
            second.localized,
            action: { setValue(second) }
        )
            .buttonStyle(ToggleButtonStyle(
                isSelected: selected == second,
                backgroundColor: backgroundColor,
                accentColor: accentColor
            ))

        
        return HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(.appInputLabel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(accentColor)
                .padding(.leading)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 1) {

                firstButton

                secondButton
            }
                .padding(1)
                .background(accentColor)
                .padding(.horizontal)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: maxHeight)
            .background(backgroundColor)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)

    }
    
    public static func Number(
        title: String,
        unit: String,
        input: Binding<String>,
        onCommit: @escaping () -> Void,
        openInput: @escaping () -> Void,
        isOpen: Bool,
        maxHeight: CGFloat,
        backgroundColor: Color,
        backgroundColorName: String,
        confirmButtonColor: Color,
        accentColor: Color
    ) -> some View {
        
        HStack(alignment: .center, spacing: 0) {

            if !isOpen {
                Text(title.uppercased())
                    .font(.appInputLabel)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(accentColor)
                    .padding(.leading)
            }
            
            Spacer()

            HStack(alignment: .center, spacing: 0) {
                TextField("", text: input, onCommit: onCommit)
                    .font(.appInputValue)
                    .padding(.trailing, 8)
                    .frame(width: 120, height: 44)
                    .border(accentColor)
                    .foregroundColor(accentColor)
                    .padding(.horizontal)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .onTapGesture(perform: openInput)
                
                Text(unit)
                    .font(.appInputLabel)
                    .frame(width: 42, alignment: .leading)
                    .foregroundColor(accentColor)
            }
                .padding(.horizontal)
            
            if isOpen {
                
                Spacer()
            }
            
            Button(
                action: onCommit,
                label: {
                    CustomImage(
                        name: "checkmark-sharp",
                        colorName: backgroundColorName
                    )
                        .frame(minWidth: 0, maxWidth: 40)
                        .frame(minHeight: 0, maxHeight: 40)
                        .clipped()
                        .frame(maxHeight: .infinity)
                        .frame(maxWidth: isOpen ? 120 : 0)
                        .background(confirmButtonColor)
                }
            )
    
        }
            .animation(.default)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: maxHeight)
            .background(backgroundColor)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
        
    }
    
    
    public static func EntryNumber(
        icon: String,
        unit: String,
        value: Binding<String>,
        onCommit: @escaping () -> Void,
        openInput: @escaping () -> Void,
        padding: CGFloat,
        backgroundColor: Color,
        accentColor: Color,
        accentColorName: String,
        accentAlternativeColor: Color,
        accentAlternativeColorName: String
    ) -> some View {

        let isEmptyInput = NumberFormatter().number(from: value.wrappedValue) == nil
        let baseColor = ( isEmptyInput ? accentAlternativeColor : accentColor )
        
        let result = HStack(alignment: .center, spacing: 0) {

            CustomImage(
                name: icon,
                colorName: isEmptyInput ? accentAlternativeColorName : accentColorName
            )
                .frame(width: 30, height: 30)
                .padding(.horizontal)
    
            TextField("", text: value, onCommit: onCommit)
                .font(.appEntryValue)
                .padding(.trailing, 8)
                .frame(width: 140, height: 44)
                .multilineTextAlignment(.trailing)
                .border(baseColor)
                .foregroundColor(baseColor)
                .padding(.horizontal)
                .keyboardType(.decimalPad)
                .onTapGesture(perform: openInput)
            
            Text(unit)
                .font(.appEntryUnit)
                .padding(.trailing)
                .frame(width: 65, alignment: .leading)
                .foregroundColor(baseColor)
        }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical, padding)
            .background(backgroundColor)
            .padding(1)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
            .padding(.horizontal, 7)
        
        return result
    }
}

struct InputBlock_Previews: PreviewProvider {
    

    static var previews: some View {
        
        ZStack {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 8) {
             
                InputBlock.Toggle(
                    title: Label.energy,
                    setValue: { print($0) },
                    first: EnergyUnit.kcal,
                    second: EnergyUnit.kj,
                    selected: EnergyUnit.kcal,
                    maxHeight: 74,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
                
                InputBlock.Number(
                    title: Label.todaysWeight,
                    unit: WeightUnit.kg.localized,
                    input: .constant("17.4"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: false,
                    maxHeight: 74,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundColorName: UIThemeManager.DEFAULT.inputBackgroundColorName,
                    confirmButtonColor: UIThemeManager.DEFAULT.inputConfirmButtonColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
                
                InputBlock.Number(
                    title: "Title",
                    unit: WeightUnit.kg.localized,
                    input: .constant("17.4"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: true,
                    maxHeight: 74,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundColorName: UIThemeManager.DEFAULT.inputBackgroundColorName,
                    confirmButtonColor: UIThemeManager.DEFAULT.inputConfirmButtonColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )

                InputBlock.EntryNumber(
                    icon: "body-sharp",
                    unit: WeightUnit.kg.localized,
                    value: .constant("71.5"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    padding: 16,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    accentAlternativeColor: UIThemeManager.DEFAULT.inputAccentAlternativeColor,
                    accentAlternativeColorName: UIThemeManager.DEFAULT.inputAccentAlternativeColorName
                )
                
                InputBlock.EntryNumber(
                    icon: "fast-food-sharp",
                    unit: EnergyUnit.kcal.localized,
                    value: .constant("2934"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    padding: 16,
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
