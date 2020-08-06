//
//  InputThemeButton.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 8/6/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct InputThemeButtonSizes {
    
    // MARK: - Sizes
    
    public let bodyVPadding: CGFloat = 1
    public let bodyHPadding: CGFloat = 8
    
    public let iconSize: CGFloat = 28
    
    public let bodyHeight: CGFloat

    // MARK: - Fonts

    public let labelFont: Font = .custom(FontOswald.Light, size: 18)

    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.bodyHeight = uiSizes.setupInputHeight
    }
}


struct InputThemeButton: View {
    
    private let style = InputThemeButtonSizes(uiSizes: UISizes.current)
    
    let title: String
    let buttonIcon: String
    
    let onClick: () -> Void
    
    let backgroundColor: Color
    let backgroundColorName: String
    let accentColor: Color
    let accentColorName: String
    
    let isSelected: Bool
    
    let palette: AnyView
    
    

    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {

            self.palette.padding(.horizontal)
            
            Text(title.uppercased())
                .font(self.style.labelFont)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(self.accentColor)
            
            Button(action: self.onClick, label: {
                CustomImage(
                    name: self.buttonIcon,
                    colorName: self.isSelected ? self.backgroundColorName : self.accentColorName
                )
                    .frame(width: self.style.iconSize, height: self.style.iconSize)
            })
                .buttonStyle(InputThemeButtonStyle(
                    backgroundColor: self.backgroundColor,
                    accentColor: self.accentColor,
                    isSelected: self.isSelected
                ))
                .padding(.horizontal)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .frame(height: self.style.bodyHeight)
            .background(self.backgroundColor)
            .padding(.vertical, self.style.bodyVPadding)
            .padding(.horizontal, self.style.bodyHPadding)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
    }
}



struct InputThemeButton_Previews: PreviewProvider {

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

                InputThemeButton(
                    title: Label.theme,
                    buttonIcon: "lock-closed-sharp",
                    onClick: { print("onClick") },
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundColorName: UIThemeManager.DEFAULT.inputBackgroundColorName,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    isSelected: false,
                    palette: AnyView( Self.colors )
                )
                
                InputThemeButton(
                    title: Label.theme,
                    buttonIcon: "checkmark-sharp",
                    onClick: { print("onClick") },
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundColorName: UIThemeManager.DEFAULT.inputBackgroundColorName,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    isSelected: false,
                    palette: AnyView( Self.colors )
                )
                
                InputThemeButton(
                    title: Label.theme,
                    buttonIcon: "checkmark-sharp",
                    onClick: { print("onClick") },
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundColorName: UIThemeManager.DEFAULT.inputBackgroundColorName,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor,
                    accentColorName: UIThemeManager.DEFAULT.inputAccentColorName,
                    isSelected: true,
                    palette: AnyView( Self.colors )
                )
            }
        }
    }
}

