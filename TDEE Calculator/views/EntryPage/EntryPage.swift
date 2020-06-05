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

    var body: some View {

        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
                
                CalendarBlock(selectedDay: self.$selectedDay)
                
                RecommendedAmountBlock()
                
                EntryInputBlock()

            }
        }
        

    }
}

struct EntryPage_Previews: PreviewProvider {
    static var previews: some View {
        EntryPage()
    }
}
