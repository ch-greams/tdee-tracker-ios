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
        updateInput: @escaping () -> Void,
        openInput: @escaping () -> Void
    ) -> some View {
        
        HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(.appTrendsItemLabel)
                .frame(width: 128, alignment: .leading)
                .padding(.horizontal, 16)
                .foregroundColor(.appPrimary)
            
            TextField("", text: input, onCommit: updateInput)
                .font(.appTrendsItemValue)
                .padding(.trailing, 8)
                .frame(width: 140, height: 44)
                .border(Color.appPrimary)
                .foregroundColor(.appPrimary)
                .padding(.trailing, 8)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numbersAndPunctuation)
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
}

struct InputBlock_Previews: PreviewProvider {
    

    static var previews: some View {
        
        ZStack {
            
            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack {
             
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
                    updateInput: { print("updateInput") },
                    openInput: { print("openInput") }
                )
            }
        }
    }
}
