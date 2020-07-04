//
//  SetupPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/9/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI




struct SetupPage: View {

    @EnvironmentObject var appState: AppState

    @State private var isReminderOpen: Bool = false

    
    var body: some View {
            
        VStack(alignment: .center, spacing: 0) {

            if !self.isReminderOpen {
                
                SetupUnitsBlock()

                SetupGoalBlock()

                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal, 32)
                    .foregroundColor(.appWhite)
                    .opacity(0.8)
            }

            SetupRemindersBlock(isOpen: self.$isReminderOpen)
                .padding(.top, self.isReminderOpen ? 60 : 0)
        }
    }
}

struct SetupPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        
        ZStack(alignment: .top) {
            
            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            SetupPage().environmentObject(appState)
        }
    }
}