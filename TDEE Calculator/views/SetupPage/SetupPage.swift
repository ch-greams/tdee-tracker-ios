//
//  SetupPage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/9/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct ToggleButtonStyle: ButtonStyle {
    
    var isSelected: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 90, height: 40)
            .font(.appSetupToggleValue)
            .foregroundColor(!self.isSelected ? Color.appPrimary : Color.white)
            .background(self.isSelected ? Color.appPrimary : Color.white)
            .border(Color.appPrimary)
    }
}


struct SetupPage: View {

    @EnvironmentObject var appState: AppState

    
    var body: some View {

        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {

                SetupUnitsBlock()
                

                SetupRemindersBlock()


                SetupGoalsBlock()
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
