//
//  TrendsPage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct TrendsPage: View {

    @EnvironmentObject var appState: AppState

    @State private var isWeightInputOpen: Bool = false
    @State private var isFoodInputOpen: Bool = false

    
    var body: some View {

        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {

                // TODO: Drop selectedDay param altogether?
                CalendarBlock(selectedDay: self.appState.selectedDay, isTrendsPage: true)
                

            }
  
        }

    }
}

struct TrendsPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        TrendsPage().environmentObject(appState)
    }
}
