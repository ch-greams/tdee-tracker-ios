//
//  SetupPage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/9/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI




struct SetupPage: View {

    @EnvironmentObject var appState: AppState

    @State private var isGoalOpen: Bool = false
    @State private var isReminderOpen: Bool = false

    
    var body: some View {
        
        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {

                if !self.isGoalOpen && !self.isReminderOpen {
                    
                    SetupUnitsBlock()
                }
                
                if !self.isGoalOpen {

                    SetupRemindersBlock(isOpen: self.$isReminderOpen)
                        .padding(.top, self.isReminderOpen ? 60 : 0)
                }

                if !self.isReminderOpen {

                    SetupGoalBlock(isOpen: self.$isGoalOpen)
                        .padding(.top, self.isGoalOpen ? 60 : 0)
                }
            }
        }
    }
}

struct SetupPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        SetupPage().environmentObject(appState)
    }
}
