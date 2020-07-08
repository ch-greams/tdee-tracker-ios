//
//  InputSelectButton.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/8/20.
//  Copyright © 2020 Greams. All rights reserved.
//

//
//  InputButton.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/8/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct InputSelectButton: View {
    
    let title: String
    let buttonLabel: String
    
    let onClick: () -> Void
    
    let height: CGFloat
    
    let backgroundColor: Color
    let accentColor: Color
    
    var isSelected: Bool = false
    
    var pallete: AnyView?
    
    

    var body: some View {
        
        let isThemeButton = self.pallete != nil
        
        return HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(.appInputLabel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .foregroundColor(self.accentColor)
            
            Spacer()
            
            if isThemeButton {
                
                self.pallete
                
                Spacer()
            }
            
            Button(buttonLabel, action: self.onClick)
                .buttonStyle(InputSelectButtonStyle(
                    backgroundColor: self.backgroundColor,
                    accentColor: self.accentColor,
                    font: isThemeButton ? Font.appSetupThemeButton : Font.appInputValue,
                    isSelected: self.isSelected
                ))
                .padding(.horizontal)

        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .frame(height: self.height)
            .background(self.backgroundColor)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
    }
}



struct InputSelectButton_Previews: PreviewProvider {

    static var colors: some View {
        
        HStack(alignment: .center, spacing: 0) {

            Rectangle()
                .frame(width: 12, height: 44)
                .foregroundColor(UIThemeManager.DEFAULT.navbarBackgroundColor)
            
            Rectangle()
                .frame(width: 12, height: 44)
                .foregroundColor(UIThemeManager.DEFAULT.inputAccentColor)

            Rectangle()
                .frame(width: 12, height: 44)
                .foregroundColor(UIThemeManager.DEFAULT.navbarAccentColor)
            
            Rectangle()
                .frame(width: 12, height: 44)
                .foregroundColor(UIThemeManager.DEFAULT.warningBackgroundColor)
        }
    }
    
    static var previews: some View {

        ZStack {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 8) {
                
                InputSelectButton(
                    title: Label.food,
                    buttonLabel: "10:33 AM",
                    onClick: { print("onClick") },
                    height: 74,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
                
                InputSelectButton(
                    title: Label.theme,
                    buttonLabel: Label.apply,
                    onClick: { print("onClick") },
                    height: 74,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    isSelected: false,
                    pallete: AnyView( Self.colors )
                )
                
                InputSelectButton(
                    title: Label.theme,
                    buttonLabel: Label.active,
                    onClick: { print("onClick") },
                    height: 74,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    isSelected: true,
                    pallete: AnyView( Self.colors )
                )
            }
        }
    }
}
