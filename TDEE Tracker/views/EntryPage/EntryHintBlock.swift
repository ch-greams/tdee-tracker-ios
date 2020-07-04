//
//  RecommendedAmountBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct EntryHintBlock: View {
    
    let isEnoughData: Bool

    let value: Int
    let unit: String

    init(value: Int, unit: String, isEnoughData: Bool = true, isFutureDate: Bool = false) {
        self.value = value
        self.unit = unit

        self.isEnoughData = isEnoughData
    }
    
    func getTextBlock(hint: String) -> some View {
        
        HStack {

            Text(hint.uppercased())
                .multilineTextAlignment(.center)
                .frame(minHeight: 46, maxHeight: 60)
                .foregroundColor(.appWhite)
                .font(.appEntryRecommendedLabel)

        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 36.0)
    }
    
    var defaultBlock: some View {
        HStack(alignment: .center, spacing: 0) {

            Text("Recommended daily amount".uppercased())
                .multilineTextAlignment(.center)
                .frame(width: 84)
                .foregroundColor(.appWhite)
                .font(.appEntryRecommendedLabel)
            
            Text("~\(self.value)")
                .frame(width: 154, alignment: .trailing)
                .foregroundColor(.appWhite)
                .font(.appEntryRecommendedAmount)
                .padding(.trailing, 10)
            
            Text(self.unit.uppercased())
                .foregroundColor(.appWhite)
                .font(.appEntryUnit)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 36.0)
    }
    
    var body: some View {
        
        let dataHint = "After enough entries were added you will see here recommended daily amount"
        
        return ZStack {

            if self.isEnoughData && self.value > 0 {

                self.defaultBlock
            }
            else {

                self.getTextBlock(hint: dataHint)
            }
        }
    }
}

struct EntryHintBlock_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            EntryHintBlock(value: 2843, unit: "kcal", isEnoughData: false).background(Color.appPrimary)
            EntryHintBlock(value: 2843, unit: "kcal").background(Color.appPrimary)
        }
    }
}
