//
//  EntryPage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct EntryPage: View {

    @State private var selectedDay: Date = Date()

    @State private var weightValue: Int?
    @State private var foodValue: Int?

    @State private var isWeightInputOpen: Bool = false
    @State private var isFoodInputOpen: Bool = false


    var body: some View {

        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {

                CalendarBlock(selectedDay: self.$selectedDay)
                
                RecommendedAmountBlock()

            }
            
            if self.isWeightInputOpen || self.isFoodInputOpen {

                // NOTE: Use "Save" button to finish data entry?
                Color.appFade.edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        self.isWeightInputOpen = false
                        self.isFoodInputOpen = false
                    }
                    .zIndex(1)
            
            }

            EntryInputBlock(
                value: self.$weightValue,
                icon: "body-sharp",
                unit: "kg"
            )
                .padding(.horizontal, 7)
                .animation(.default)
                .padding(.top, self.isWeightInputOpen ? 160 : 458)
                .onTapGesture { self.isWeightInputOpen = true }
                .zIndex(self.isWeightInputOpen ? 1 : 0)

            EntryInputBlock(
                value: self.$foodValue,
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
    static var previews: some View {
        EntryPage()
    }
}
