//
//  RecommendedAmountBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct RecAmountBlock: View {
    
    let isEnoughData: Bool
    
    let value: Int
    let unit: String
    
    
    var notEnoughDataBlock: some View {
        
        let hint = "After first week we'll be able to provide here recommended daily intake amount"
        
        return HStack {

            Text(hint.uppercased())
                .multilineTextAlignment(.center)
                .frame(height: 60)
                .foregroundColor(.white)
                .font(.appEntryRecommendedLabel)

        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 36.0)
            .padding(.vertical, 10.0)
    }
    
    var defaultBlock: some View {
        HStack(alignment: .center, spacing: 0) {

            Text("Recommended daily amount".uppercased())
                .multilineTextAlignment(.center)
                .frame(width: 84)
                .foregroundColor(.white)
                .font(.appEntryRecommendedLabel)
            
            Text("~\(self.value)")
                .frame(width: 154, alignment: .trailing)
                .foregroundColor(.white)
                .font(.appEntryRecommendedAmount)
                .padding(.trailing, 10)
            
            Text(self.unit.uppercased())
                .foregroundColor(.white)
                .font(.appEntryUnit)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 36.0)
            .padding(.vertical, 10.0)
    }
    
    var body: some View {
        
        ZStack {
            if self.isEnoughData {

                self.defaultBlock
            }
            else {

                self.notEnoughDataBlock
            }
        }
    }
}

struct RecAmountBlock_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            RecAmountBlock(isEnoughData: false, value: 2843, unit: "kcal").background(Color.appPrimary)
            RecAmountBlock(isEnoughData: true, value: 2843, unit: "kcal").background(Color.appPrimary)
        }
    }
}
