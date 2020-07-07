//
//  ContentView.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

enum TabBarTag: Int {
    case entryPage, trendsPage, progressPage, setupPage
}

struct TabBarItem {
    
    let label: String
    let icon: String
    let tag: TabBarTag
}

struct ContentView: View {

    @EnvironmentObject var appState: AppState
    
    @State var selectedTab = TabBarTag.entryPage
    
    let tabBarItems: [ TabBarItem ] = [
        TabBarItem(label: Label.entry, icon: "create-sharp", tag: TabBarTag.entryPage),
        TabBarItem(label: Label.trends, icon: "calendar-sharp", tag: TabBarTag.trendsPage),
        TabBarItem(label: Label.progress, icon: "stats-chart-sharp", tag: TabBarTag.progressPage),
        TabBarItem(label: Label.settings, icon: "options-sharp", tag: TabBarTag.setupPage)
    ]
    
    func tabbarItem(item: TabBarItem) -> some View {

        let isSelected = ( item.tag == self.selectedTab )
        
        return Button(action: { self.selectedTab = item.tag }) {

            VStack(alignment: .center, spacing: 2) {
                
                CustomImage(
                    name: item.icon,
                    colorName: (
                        isSelected
                            ? self.appState.uiTheme.mainTextColorName
                            : self.appState.uiTheme.navbarAccentColorName
                    )
                )
                    .frame(width: 26, height: 26)
                    .padding(.top, self.appState.uiSizes.navbarPadding)

                Text(item.label)
                    .font(.appNavbarElement)
                    .foregroundColor(
                        isSelected
                            ? self.appState.uiTheme.mainTextColor
                            : self.appState.uiTheme.navbarAccentColor
                )
            }
        }
    }
    
    var warningMessageBlock: some View {
        
        HStack {

            Text(self.appState.messageText.uppercased())
                .multilineTextAlignment(.center)
                .frame(height: 60)
                .foregroundColor(self.appState.uiTheme.mainTextColor)
                .font(.appWarningText)

        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 32)
            .background(self.appState.uiTheme.warningBackgroundColor)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
    }

    
    var mainAppView: some View {
        
        switch self.selectedTab {

            case TabBarTag.entryPage:
                return AnyView( EntryPage() )
            case TabBarTag.trendsPage:
                return AnyView( TrendsPage() )
            case TabBarTag.progressPage:
                return AnyView( ProgressPage() )
            case TabBarTag.setupPage:
                return AnyView( SetupPage() )
        }
    }
    
    var navbarView: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(self.appState.uiTheme.navbarAccentColor)
                .opacity(0.5)
            
            HStack(alignment: .center, spacing: self.appState.uiSizes.navbarSpacing) {
                
                ForEach(self.tabBarItems, id: \.tag) { item in
                    self.tabbarItem(item: item)
                }
            }
                .frame(maxWidth: .infinity)
                .frame(height: self.appState.uiSizes.navbarHeight, alignment: .top)
                .background(self.appState.uiTheme.navbarBackgroundColor)
                
        }
    }

    var body: some View {
        
        ZStack(alignment: .top) {
            
            self.appState.uiTheme.backgroundColor.edgesIgnoringSafeArea(.all)
                
            if self.appState.isFirstSetupDone {

                self.mainAppView
                    .padding(.top, self.appState.uiSizes.mainViewPadding)
                
                self.navbarView
                    .padding(.top, self.appState.uiSizes.mainViewNavbarPadding)
            }
            else {

                WelcomePage()
            }

            if !self.appState.messageText.isEmpty {

                self.warningMessageBlock
                    .padding(.top, (
                        self.appState.isFirstSetupDone
                            ? self.appState.uiSizes.mainViewPadding
                            : 0
                    ))
            }
        }
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        ContentView().environmentObject(appState)
    }
}
