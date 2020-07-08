//
//  SetupTheme.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/8/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct SetupThemeBlock: View {
    
    @EnvironmentObject var appState: AppState
    
    
    
    func getPalleteView(theme: UITheme) -> some View {
        
        HStack(alignment: .center, spacing: 0) {

            Rectangle()
                .frame(width: 10, height: 40)
                .foregroundColor(theme.navbarBackgroundColor)
            
            Rectangle()
                .frame(width: 10, height: 40)
                .foregroundColor(theme.inputAccentColor)

            Rectangle()
                .frame(width: 10, height: 40)
                .foregroundColor(theme.navbarAccentColor)
            
            Rectangle()
                .frame(width: 10, height: 40)
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
                
                InputSelectButton(
                    title: key.localized,
                    buttonLabel: ( self.appState.currentTheme == key ) ? Label.active : Label.apply,
                    onClick: { self.appState.saveTheme(key) },
                    height: self.appState.uiSizes.setupInputHeight,
                    backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                    accentColor: self.appState.uiTheme.inputAccentColor,
                    isSelected: ( self.appState.currentTheme == key ),
                    pallete: AnyView( self.getPalleteView(theme: value) )
                )
            }
        }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 24)
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
