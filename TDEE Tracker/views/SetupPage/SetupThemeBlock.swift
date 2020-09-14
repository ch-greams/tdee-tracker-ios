//
//  SetupTheme.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/8/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct SetupThemeBlockSizes {
    
    // MARK: - Sizes
    
    public let paletteColorWidth: CGFloat = 10
    public let paletteColorHeight: CGFloat = 40
    
    public let bodyBPadding: CGFloat = 24
}


struct SetupThemeBlock: View {
    
    private let sizes = SetupThemeBlockSizes()
    
    @EnvironmentObject var appState: AppState
    
    
    func getButtonIcon(key: UIThemeType) -> String {
        
        return (
            (self.appState.currentTheme == key) || self.appState.isPremiumVersion
                ? "checkmark-sharp"
                : "lock-closed-sharp"
        )
    }
    
    func getButtonAction(key: UIThemeType) -> () -> Void {
        
        return (
            self.appState.isPremiumVersion
                ? { self.appState.saveTheme(key) }
                : { self.appState.unlockTheme() }
        )
    }
    

    func getPaletteView(theme: UITheme) -> some View {
        
        HStack(alignment: .center, spacing: 0) {

            Rectangle()
                .frame(
                    width: self.sizes.paletteColorWidth,
                    height: self.sizes.paletteColorHeight
                )
                .foregroundColor(theme.navbarBackgroundColor)
            
            Rectangle()
                .frame(
                    width: self.sizes.paletteColorWidth,
                    height: self.sizes.paletteColorHeight
                )
                .foregroundColor(theme.inputAccentColor)

            Rectangle()
                .frame(
                    width: self.sizes.paletteColorWidth,
                    height: self.sizes.paletteColorHeight
                )
                .foregroundColor(theme.navbarAccentColor)
            
            Rectangle()
                .frame(
                    width: self.sizes.paletteColorWidth,
                    height: self.sizes.paletteColorHeight
                )
                .foregroundColor(theme.warningBackgroundColor)
        }
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            SetupBlockTitle(
                title: Label.theme,
                textColor: self.appState.uiTheme.mainTextColor
            )
            
            ForEach(UIThemeManager.ALL_THEMES, id: \.key) { (key, value) in
                
                InputCheckButton(
                    title: key.localized,
                    buttonIcon: self.getButtonIcon(key: key),
                    onClick: self.getButtonAction(key: key),
                    backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                    backgroundColorName: self.appState.uiTheme.inputBackgroundColorName,
                    accentColor: self.appState.uiTheme.inputAccentColor,
                    accentColorName: self.appState.uiTheme.inputAccentColorName,
                    isSelected: ( self.appState.currentTheme == key ),
                    palette: AnyView( self.getPaletteView(theme: value) )
                )
            }
        }
            .frame(maxWidth: .infinity)
            .padding(.bottom, self.sizes.bodyBPadding)
    }
}

struct SetupThemeBlock_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        SetupThemeBlock()
            .padding(.vertical, 8)
            .background(UIThemeManager.DEFAULT.backgroundColor)
            .environmentObject(Self.appState)
    }
}
