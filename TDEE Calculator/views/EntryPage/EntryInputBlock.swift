//
//  EntryInputBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct EntryInputBlock: View {
    
    @Binding var value: String
    
    var onCommit: () -> Void
    
    var icon: String
    var unit: String

    
    var body: some View {
        
        let baseColor = (
            NumberFormatter().number(from: self.value) == nil
                ? Color.appSecondary
                : Color.appPrimary
        )
        
        let result = HStack {

            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30.0)
                .foregroundColor(baseColor)
                .padding(.horizontal, 8)
    
            TextField("", text: self.$value, onCommit: self.onCommit)
                .font(.appEntryValue)
                .padding([.top, .leading, .trailing], 4.0)
                .frame(width: 140, height: 44)
                .multilineTextAlignment(.trailing)
                .border(baseColor)
                .foregroundColor(baseColor)
                .padding(.horizontal, 16)
                .keyboardType(.numbersAndPunctuation)
            
            Text(unit.uppercased())
                .font(.appEntryUnit)
                .padding(.trailing, 16.0)
                .frame(width: 60, alignment: .leading)
                .foregroundColor(baseColor)


        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 70)
        .padding()
        .background(Color.white)
        .padding(1)
        .clipped()
        .shadow(color: .appFade, radius: 1, x: 1, y: 1)
        
        return result
    }

}

struct EntryInputBlock_Previews: PreviewProvider {
    
    static var previews: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            EntryInputBlock(
                value: .constant("76.5"), onCommit: { print("weight") }, icon: "body-sharp", unit: "kg"
            )
            
            EntryInputBlock(
                value: .constant("2843"), onCommit: { print("food") }, icon: "fast-food-sharp", unit: "kcal"
            )
            
        }
        .padding(7)
        .background(Color.appPrimaryDark)
    }
}
