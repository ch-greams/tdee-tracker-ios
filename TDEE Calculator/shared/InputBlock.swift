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
        selected: Optional<T>
    ) -> some View {
        
        let label = Text(title.uppercased())
            .font(.appTrendsItemLabel)
            .frame(width: 128, alignment: .leading)
            .padding(.horizontal, 16)
            .foregroundColor(.appPrimary)

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

            label
            
            HStack(alignment: .center, spacing: 1) {

                firstButton

                secondButton
            }
                .padding(1)
                .background(Color.appPrimary)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .frame(height: 74)
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
        openInput: @escaping () -> Void
    ) -> some View {
        
        HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(.appTrendsItemLabel)
                .frame(width: 128, alignment: .leading)
                .padding(.horizontal, 16)
                .foregroundColor(.appPrimary)
            
            TextField("", text: input, onCommit: onCommit)
                .font(.appTrendsItemValue)
                .padding(.trailing, 8)
                .frame(width: 140, height: 44)
                .border(Color.appPrimary)
                .foregroundColor(.appPrimary)
                .padding(.trailing, 8)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .onTapGesture(perform: openInput)
            
            Text(unit.uppercased())
                .font(.appTrendsItemLabel)
                .frame(width: 42, alignment: .leading)
                .foregroundColor(.appPrimary)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .frame(height: 74)
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
        openInput: @escaping () -> Void
    ) -> some View {

        let baseColor = (
            NumberFormatter().number(from: value.wrappedValue) == nil
                ? Color.appSecondary
                : Color.appPrimary
        )
        
        let result = HStack(alignment: .center, spacing: 0) {

            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(baseColor)
                .padding(.horizontal, 8)
    
            TextField("", text: value, onCommit: onCommit)
                .font(.appEntryValue)
                .padding([.top, .leading, .trailing], 4)
                .frame(width: 140, height: 44)
                .multilineTextAlignment(.trailing)
                .border(baseColor)
                .foregroundColor(baseColor)
                .padding(.horizontal, 16)
                .keyboardType(.decimalPad)
                .onTapGesture(perform: openInput)
            
            Text(unit.uppercased())
                .font(.appEntryUnit)
                .padding(.trailing, 16)
                .frame(width: 60, alignment: .leading)
                .foregroundColor(baseColor)


        }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 70)
            .padding()
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
                    selected: EnergyUnit.kcal
                )
                
                InputBlock.Number(
                    title: "Title",
                    unit: "kg",
                    input: .constant("17.4"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") }
                )
                
                InputBlock.EntryNumber(
                    icon: "body-sharp",
                    unit: "kg",
                    value: .constant("71.4"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") }
                )
                
                InputBlock.EntryNumber(
                    icon: "fast-food-sharp",
                    unit: "kcal",
                    value: .constant("2934"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") }
                )
            }
        }
    }
}
