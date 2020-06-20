//
//  ContentView.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab = Tab.entryPage
    
    enum Tab: Int {
        case entryPage, trendsPage, progressPage, setupPage
    }
    
    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
            Text(text)
        }
    }
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            EntryPage()
                .tabItem { self.tabbarItem(text: "Entry", image: "calendar.badge.plus") }
                .tag(Tab.entryPage)

            TrendsPage()
                .tabItem { self.tabbarItem(text: "Trends", image: "calendar") }
                .tag(Tab.trendsPage)

            ProgressPage()
                .tabItem { self.tabbarItem(text: "Progress", image: "chart.bar.fill") }
                .tag(Tab.progressPage)

            SetupPage()
                .tabItem { self.tabbarItem(text: "Setup", image: "slider.horizontal.3") }
                .tag(Tab.setupPage)
        }
        .accentColor(Color.appPrimaryDark)
        

    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        ContentView().environmentObject(appState)
    }
}
