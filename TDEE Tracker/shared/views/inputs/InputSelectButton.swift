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


struct InputSelectButtonSizes {
    
    // MARK: - Sizes
    
    public let bodyVPadding: CGFloat = 1
    public let bodyHPadding: CGFloat = 8
    
    public let bodyHeight: CGFloat

    // MARK: - Fonts

    public let labelFont: Font = .custom(FontOswald.Light, size: 18)

    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.bodyHeight = uiSizes.setupInputHeight
    }
}


struct InputSelectButton: View {
    
    private let style: InputSelectButtonSizes = InputSelectButtonSizes(uiSizes: UISizes.current)
    
    let title: String
    let buttonLabel: String
    
    let onClick: () -> Void
    
    let backgroundColor: Color
    let accentColor: Color
    
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(self.style.labelFont)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .foregroundColor(self.accentColor)
            
            Button(buttonLabel, action: self.onClick)
                .buttonStyle(InputSelectButtonStyle(
                    backgroundColor: self.backgroundColor,
                    accentColor: self.accentColor
                ))
                .padding(.horizontal)
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: self.style.bodyHeight)
            .background(self.backgroundColor)
            .padding(.vertical, self.style.bodyVPadding)
            .padding(.horizontal, self.style.bodyHPadding)
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
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
            }
        }
    }
}
