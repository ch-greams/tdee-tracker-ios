//
//  SetupRemindersBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct SetupRemindersBlock: View {
    
    @State private var value: String = ""

    
    func getInputBlock(title: String) -> some View {
        
        let inputBlock = HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(.appTrendsItemLabel)
                .frame(width: 128, alignment: .leading)
                .padding(.horizontal, 16)
                .foregroundColor(.appPrimary)
            
            TextField("", text: self.$value)
                .font(.appEntryValue)
                .frame(width: 180, height: 44)
                .border(Color.appPrimary)
                .font(.appEntryRecommendedAmount)
                .foregroundColor(.appPrimary)
                .padding(.trailing, 8)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)   // limit input to numbers
                //.accentColor(.clear)        // hide cursor

        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .frame(height: 74)
            .background(Color.white)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .appFade, radius: 1, x: 1, y: 1)
        
        return inputBlock
        
    }
    
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 0) {

            SetupBlockTitle(title: "Reminders")
            
            self.getInputBlock(title: "Food")
            
            self.getInputBlock(title: "Weight")
        }
    }
}

struct SetupRemindersBlock_Previews: PreviewProvider {
    static var previews: some View {
        SetupRemindersBlock()
            .padding(.vertical, 8)
            .background(Color.appPrimary)
    }
}
