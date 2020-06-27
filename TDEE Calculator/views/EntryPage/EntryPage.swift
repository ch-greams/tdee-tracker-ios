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

    
    
    func onSubmit() {

        UIApplication.shared.endEditing()
        
        if self.isWeightInputOpen {
            
            self.appState.updateWeightFromInput()
            self.isWeightInputOpen = false
        }
        
        if self.isFoodInputOpen {
            
            self.appState.updateEnergyFromInput()
            self.isFoodInputOpen = false
        }
    }
    
    
    var body: some View {
        
        let lockIconSize: CGFloat = 80
        
        return ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {

                CalendarBlock(
                    selectedDay: self.appState.selectedDay,
                    isTrendsPage: false
                )
                
                EntryHintBlock(
                    isEnoughData: self.appState.isEnoughDataForRecommendation,
                    value: self.appState.recommendedFoodAmount,
                    unit: self.appState.energyUnit.rawValue
                )
            }
            
            if self.isWeightInputOpen || self.isFoodInputOpen {
                Color.appFade.edgesIgnoringSafeArea(.all)
                    .onTapGesture(perform: self.onSubmit)
                    .zIndex(1)
            }


            EntryInputBlock(
                value: self.$appState.weightInput,
                onCommit: self.onSubmit,
                icon: "body-sharp",
                unit: self.appState.weightUnit.rawValue
            )
                .padding(.horizontal, 7)
                .animation(.easeOut(duration: 0.16))
                .padding(.top, self.isWeightInputOpen ? 160 : 458)
                .onTapGesture { self.isWeightInputOpen = true }
                .zIndex(self.isWeightInputOpen ? 1 : 0)

            EntryInputBlock(
                value: self.$appState.foodInput,
                onCommit: self.onSubmit,
                icon: "fast-food-sharp",
                unit: self.appState.energyUnit.rawValue
            )
                .padding(.horizontal, 7)
                .animation(.easeOut(duration: 0.16))
                .padding(.top, self.isFoodInputOpen ? 160 : 562)
                .onTapGesture { self.isFoodInputOpen = true }
                .zIndex(self.isFoodInputOpen ? 1 : 0)

            if self.appState.isFutureDate {

                HStack{
                    Image(systemName: "clock.fill")
                        .frame(width: lockIconSize, height: lockIconSize)
                        .font(.system(size: lockIconSize))
                        .foregroundColor(.appPrimaryDark)
                }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .frame(height: 210)
                    .background(Color.appPrimary)
                    .opacity(0.8)
                    .padding(.top, 458)
            }
        }


    }
}

struct EntryPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        EntryPage().environmentObject(appState)
    }
}
