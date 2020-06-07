//
//  WeeklyTrendsBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct WeeklyTrendsBlock: View {

    let selectedDay: Date

    func getLine(label: String, value: String, unit: String, change: String) -> some View {
        
        return HStack(alignment: .center, spacing: 0) {
        
            Text(label)
                .frame(width: 140, alignment: .leading)
                .padding(.leading, 30)
                .padding(.trailing, 20)
            
            Text(value)
                .frame(width: 50, alignment: .trailing)
                .padding(.trailing, 10)

            Text(unit)
                .frame(width: 50, alignment: .leading)
                .padding(.trailing, 10)

            Text(change)
                .padding(.trailing, 30)

        }
        .frame(height: 68)
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {

            self.getLine(label: "FOOD", value: "2843", unit: "KCAL", change: "+")
            self.getLine(label: "WEIGHT", value: "76", unit: "KG", change: "+")
            self.getLine(label: "TDEE", value: "2843", unit: "KCAL", change: "+")
            self.getLine(label: "WEIGHT CHANGE", value: "+ 0.3", unit: "KG", change: "+")
            
        }
        .frame(width: 358, height: 280)
        .background(Color(.white))
        .padding(8)
        .clipped()
        .shadow(color: .gray, radius: 1, x: 1, y: 1)
    }
}

struct WeeklyTrendsBlock_Previews: PreviewProvider {

    static var previews: some View {
        WeeklyTrendsBlock(selectedDay: Date())
            .background(Color.appPrimary)
    }
}
