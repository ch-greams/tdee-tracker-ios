//
//  InputToggle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct InputToggle<T>: View where T:Equatable, T:Localizable {
    
    let title: String
    let setValue: (T) -> Void
    let first: T
    let second: T
    let selected: Optional<T>
    let maxHeight: CGFloat
    let backgroundColor: Color
    let accentColor: Color
    
    @State private var animation: Animation? = nil
    
    
    var body: some View {

        let firstButton = Button(
            first.localized,
            action: { self.setValue(self.first) }
        )
            .buttonStyle(InputToggleButtonStyle(
                isSelected: selected == first,
                backgroundColor: backgroundColor,
                accentColor: accentColor
            ))
        
        let secondButton = Button(
            second.localized,
            action: { self.setValue(self.second) }
        )
            .buttonStyle(InputToggleButtonStyle(
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
            .animation(self.animation)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: maxHeight)
            .background(backgroundColor)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
            .onAppear {
                DispatchQueue.main.async { self.animation = .default }
            }
    }
}


struct InputToggle_Previews: PreviewProvider {

    static var previews: some View {

        ZStack {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 8) {
             
                InputToggle(
                    title: Label.energy,
                    setValue: { print($0) },
                    first: EnergyUnit.kcal,
                    second: EnergyUnit.kj,
                    selected: EnergyUnit.kcal,
                    maxHeight: 74,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
            }
        }
    }
}
