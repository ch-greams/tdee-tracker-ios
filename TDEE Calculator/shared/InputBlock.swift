//
//  InputBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/25/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



class InputBlock {
    
    
    public static func Toggle<T: Equatable>(
        title: String,
        setValue: @escaping (T) -> Void,
        first: (value: T, label: String),
        second: (value: T, label: String),
        selected: Optional<T>,
        maxHeight: CGFloat
    ) -> some View {

        let firstButton = Button(
            first.label.uppercased(),
            action: { setValue(first.value) }
        )
            .buttonStyle(ToggleButtonStyle(isSelected: selected == first.value))
        
        let secondButton = Button(
            second.label.uppercased(),
            action: { setValue(second.value) }
        )
            .buttonStyle(ToggleButtonStyle(isSelected: selected == second.value))

        
        return HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(.appInputLabel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.appPrimary)
                .padding(.leading)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 1) {

                firstButton

                secondButton
            }
                .padding(1)
                .background(Color.appPrimary)
                .padding(.horizontal)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: maxHeight)
            .background(Color.white)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .appFade, radius: 1, x: 1, y: 1)

    }
    
    public static func Number(
        title: String,
        unit: String,
        input: Binding<String>,
        onCommit: @escaping () -> Void,
        openInput: @escaping () -> Void,
        isOpen: Bool,
        maxHeight: CGFloat
    ) -> some View {
        
        HStack(alignment: .center, spacing: 0) {

            if !isOpen {
                Text(title.uppercased())
                    .font(.appInputLabel)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.appPrimary)
                    .padding(.leading)
            }
            
            Spacer()

            HStack(alignment: .center, spacing: 0) {
                TextField("", text: input, onCommit: onCommit)
                    .font(.appInputValue)
                    .padding(.trailing, 8)
                    .frame(width: 120, height: 44)
                    .border(Color.appPrimary)
                    .foregroundColor(.appPrimary)
                    .padding(.horizontal)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .onTapGesture(perform: openInput)
                
                Text(unit.uppercased())
                    .font(.appInputLabel)
                    .frame(width: 42, alignment: .leading)
                    .foregroundColor(.appPrimary)
            }
                .padding(.horizontal)
            
            if isOpen {
                
                Spacer()
            }
            
            Button(
                action: onCommit,
                label: {
                    CustomImage(name: "checkmark-sharp")
                        .frame(minWidth: 0, maxWidth: 40)
                        .frame(minHeight: 0, maxHeight: 40)
                        .clipped()
                        .frame(maxHeight: .infinity)
                        .frame(maxWidth: isOpen ? 120 : 0)
                        .background(Color.appPrimaryDark)
                }
            )
    
        }
            .animation(.default)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: maxHeight)
            .background(Color.white)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .appFade, radius: 1, x: 1, y: 1)
        
    }
    
    
    public static func EntryNumber(
        icon: String,
        unit: String,
        value: Binding<String>,
        onCommit: @escaping () -> Void,
        openInput: @escaping () -> Void,
        padding: CGFloat
    ) -> some View {

        let isEmptyInput = NumberFormatter().number(from: value.wrappedValue) == nil
        let baseColor = ( isEmptyInput ? Color.appSecondary : Color.appPrimary )
        
        let result = HStack(alignment: .center, spacing: 0) {

            CustomImage(
                name: icon,
                colorName: isEmptyInput ? Color.appSecondaryName : Color.appPrimaryName
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
            
            Text(unit.uppercased())
                .font(.appEntryUnit)
                .padding(.trailing)
                .frame(width: 60, alignment: .leading)
                .foregroundColor(baseColor)
        }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical, padding)
            .background(Color.white)
            .padding(1)
            .clipped()
            .shadow(color: .appFade, radius: 1, x: 1, y: 1)
            .padding(.horizontal, 7)
        
        return result
    }
}

struct InputBlock_Previews: PreviewProvider {
    

    static var previews: some View {
        
        ZStack {
            
            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 8) {
             
                InputBlock.Toggle(
                    title: "Title",
                    setValue: { print($0) },
                    first: (value: EnergyUnit.kcal, label: EnergyUnit.kcal.rawValue),
                    second: (value: EnergyUnit.kj, label: EnergyUnit.kj.rawValue),
                    selected: EnergyUnit.kcal,
                    maxHeight: 74
                )
                
                InputBlock.Number(
                    title: "Today's Weight",
                    unit: "kg",
                    input: .constant("17.4"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: false,
                    maxHeight: 74
                )
                
                InputBlock.Number(
                    title: "Title",
                    unit: "kg",
                    input: .constant("17.4"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: true,
                    maxHeight: 74
                )

                InputBlock.EntryNumber(
                    icon: "body-sharp",
                    unit: "kg",
                    value: .constant("71.4"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    padding: 16
                )
                
                InputBlock.EntryNumber(
                    icon: "fast-food-sharp",
                    unit: "kcal",
                    value: .constant("2934"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    padding: 16
                )
            }
        }
    }
}
