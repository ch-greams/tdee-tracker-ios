//
//  EntryPage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct EntryPage: View {

    @EnvironmentObject var appState: AppState

    @State private var isWeightInputOpen: Bool = false
    @State private var isFoodInputOpen: Bool = false

    
    var body: some View {

        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {

                // TODO: Drop selectedDay param altogether?
                CalendarBlock(selectedDay: self.appState.selectedDay)
                
                RecAmountBlock()
            }
            
            if self.isWeightInputOpen || self.isFoodInputOpen {

                // NOTE: Use "Save" button to finish data entry?
                Color.appFade.edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        
                        UIApplication.shared.endEditing()
                        
                        if self.isWeightInputOpen {
                            
                            self.appState.updateWeightInEntry()
                            self.isWeightInputOpen = false
                        }
                        
                        if self.isFoodInputOpen {
                            
                            self.appState.updateFoodInEntry()
                            self.isFoodInputOpen = false
                        }
                        
                    }
                    .zIndex(1)
            
            }


            EntryInputBlock(
                value: $appState.weight,
                icon: "body-sharp",
                unit: "kg"
            )
                .padding(.horizontal, 7)
                .animation(.default)
                .padding(.top, self.isWeightInputOpen ? 160 : 458)
                .onTapGesture { self.isWeightInputOpen = true }
                .zIndex(self.isWeightInputOpen ? 1 : 0)

            EntryInputBlock(
                value: $appState.food,
                icon: "fast-food-sharp",
                unit: "kcal"
            )
                .padding(.horizontal, 7)
                .animation(.default)
                .padding(.top, self.isFoodInputOpen ? 160 : 562)
                .onTapGesture { self.isFoodInputOpen = true }
                .zIndex(self.isFoodInputOpen ? 1 : 0)
                
        }


    }
}

struct EntryPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        EntryPage().environmentObject(appState)
    }
}
