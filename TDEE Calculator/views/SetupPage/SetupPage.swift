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
    
    
    var body: some View {
        
        let doneAction = {
            UIApplication.shared.endEditing()
            self.isGoalOpen = false
            
            //self.appState.updateTargetSurplus()
            //self.appState.saveGoalWeight()
            //self.appState.saveGoalWeeklyDelta()
        }
        
        return ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {

                if !isGoalOpen {
                    
                    SetupUnitsBlock()
                    
                    SetupRemindersBlock()
                }

                SetupGoalBlock(isGoalOpen: self.$isGoalOpen)
                    .padding(.top, isGoalOpen ? 60 : 0)
                
                if isGoalOpen {
                
                    Button("Done", action: doneAction)
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
