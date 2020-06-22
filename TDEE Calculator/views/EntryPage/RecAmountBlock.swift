//
//  RecommendedAmountBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct RecAmountBlock: View {
    
    let value: Int
    let unit: String
    
    var body: some View {
        
        HStack {

            Text("Recommended daily amount".uppercased())
                .multilineTextAlignment(.center)
                .frame(width: 84)
                .foregroundColor(.white)
                .font(.appEntryRecommendedLabel)
            
            Spacer()
            
            Text("~\(self.value)")
                .foregroundColor(.white)
                .font(.appEntryRecommendedAmount)
            Text(self.unit.uppercased())
                .foregroundColor(.white)
                .font(.appEntryUnit)
        }
            .padding(.horizontal, 36.0)
            .padding(.vertical, 10.0)
    }
}

struct RecAmountBlock_Previews: PreviewProvider {
    static var previews: some View {
        RecAmountBlock(value: 2843, unit: "kcal").background(Color.appPrimary)
    }
}
