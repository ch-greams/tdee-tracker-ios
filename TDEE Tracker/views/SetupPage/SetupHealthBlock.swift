//
//  SetupHealthBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 9/15/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct SetupHealthBlockSizes {
    
    
    // MARK: - Sizes
    
    public let hintHPadding: CGFloat = 18
    public let hintTPadding: CGFloat = 6
    
    // MARK: - Fonts
    
    public let welcomeHintFont: Font

    // MARK: - Init
    
    init(uiSizes: UISizes) {

        self.welcomeHintFont = .custom(FontOswald.Light, size: 14)
    }
}
    
    

struct SetupHealthBlock: View {
    
    private let sizes = SetupHealthBlockSizes(uiSizes: UISizes.current)
    
    @EnvironmentObject var appState: AppState
    
    @State var isHealthSyncing: Bool = false {
        didSet {
            if self.isHealthSyncing {
                Timer.scheduledTimer(
                    withTimeInterval: 1,
                    repeats: false,
                    block: { _ in self.isHealthSyncing = false }
                )
            }
        }
    }
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            SetupBlockTitle(
                title: Label.integrations,
                textColor: self.appState.uiTheme.mainTextColor
            )
            
            InputCheckButton(
                title: Label.appleHealth,
                buttonIcon: "sync-sharp",
                onClick: {
                    if !self.isHealthSyncing {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()

                        self.isHealthSyncing = true
                        HealthStoreManager.requestPermissionsAndFetchHealthData()
                    }
                },
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                backgroundColorName: self.appState.uiTheme.inputBackgroundColorName,
                accentColor: self.appState.uiTheme.inputAccentColor,
                accentColorName: self.appState.uiTheme.inputAccentColorName,
                isSelected: self.isHealthSyncing
            )
            
            Text(Label.appleHealthHint)
                .font(self.sizes.welcomeHintFont)
                .foregroundColor(self.appState.uiTheme.mainTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, self.sizes.hintHPadding)
                .padding(.top, self.sizes.hintTPadding)
        }
            .frame(maxWidth: .infinity)
    }
}

struct SetupHealthBlock_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        SetupHealthBlock()
            .padding(.vertical, 8)
            .background(UIThemeManager.DEFAULT.backgroundColor)
            .environmentObject(Self.appState)
    }
}
