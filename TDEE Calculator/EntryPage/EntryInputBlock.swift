//
//  EntryInputBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct EntryInputBlock: View {
    
    
    @State private var weightValue = "0.0"
    @State private var foodValue = "0"

    func getInput(type: String, value: Binding<String>, icon: String, in unit: String) -> some View {
        
        
        let result = HStack {

            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30.0)
                .foregroundColor(.appPrimary)
                .padding(.horizontal, 8)

            
            TextField(type, text: value)
                .font(.appEntryValue)
                .padding([.top, .leading, .trailing], 4.0)
                .frame(width: 140, height: 44)
                .multilineTextAlignment(.trailing)
                .border(Color.appPrimary)
                .font(.appEntryRecommendedAmount)
                .foregroundColor(.appPrimary)
                .padding(.horizontal, 16)
            
            Text(unit.uppercased())
                .font(.appEntryUnit)
                .padding(.trailing, 16.0)
                .frame(width: 60, alignment: .leading)
                .foregroundColor(.appPrimary)


        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 70)
        .padding()
        .background(Color.white)
        
        return result
    }
    
    var body: some View {

        VStack(alignment: .center, spacing: 0) {
            getInput(type: "Weight", value: $weightValue, icon: "body-sharp", in: "kg")
                .padding(1)
            
            getInput(type: "Food", value: $foodValue, icon: "fast-food-sharp", in: "kcal")
                .padding(1)
        }
        .padding(7)
        .clipped()
        .shadow(color: .gray, radius: 1, x: 1, y: 1)
    }
}

struct EntryInputBlock_Previews: PreviewProvider {
    static var previews: some View {
        EntryInputBlock().background(Color.appPrimaryDark)
    }
}
