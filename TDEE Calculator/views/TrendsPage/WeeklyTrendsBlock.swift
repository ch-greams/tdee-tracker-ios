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

    func getLine(label: String, value: String, unit: String, changeIcon: String) -> some View {
        
        return HStack(alignment: .center, spacing: 0) {
        
            Text(label)
                .font(.appTrendsItemLabel)
                .foregroundColor(.appPrimary)
                .frame(width: 120, alignment: .leading)
                .padding(.horizontal, 30)
            
            Text(value)
                .font(.appTrendsItemValue)
                .foregroundColor(.appPrimary)
                .frame(width: 72, alignment: .trailing)
                .padding(.trailing, 10)

            Text(unit)
                .font(.appTrendsItemUnit)
                .foregroundColor(.appPrimary)
                .frame(width: 30, alignment: .leading)
                .padding(.trailing, 10)

            Image(systemName: changeIcon)
                .foregroundColor(.appPrimary)
                .padding(.trailing, 30)
        }
        .frame(height: 64)
    }
    
    func getSeparator() -> some View {
        return Rectangle()
            .foregroundColor(.appPrimaryTextLight)
            .frame(height: 1)
            .padding(.horizontal, 16)
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {

            // TODO: Use ForEach?
            
            self.getLine(label: "FOOD", value: "2843", unit: "KCAL", changeIcon: "chevron.up")
            
            self.getSeparator()
            
            self.getLine(label: "WEIGHT", value: "76", unit: "KG", changeIcon: "chevron.down")
            
            self.getSeparator()
            
            self.getLine(label: "TDEE", value: "2843", unit: "KCAL", changeIcon: "chevron.down")
            
            self.getSeparator()
            
            self.getLine(label: "WEIGHT CHANGE", value: "+ 0.3", unit: "KG", changeIcon: "chevron.up")
            
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
