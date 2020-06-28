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
    
    func doneAction() {

        UIApplication.shared.endEditing()
        self.isGoalOpen = false
        self.isReminderOpen = false

        NotificationManager.updateNotificationTimes(
            weightTime: self.appState.reminderWeightTime,
            foodTime: self.appState.reminderFoodTime
        )
    }
    
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
                
                // TODO: Move into specific views?
                if self.isGoalOpen || self.isReminderOpen {
                
                    Button("Done", action: self.doneAction)
                        .buttonStyle(ToggleButtonStyle(isSelected: true))
                        .frame(width: 160)
                        .border(Color.white)
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
