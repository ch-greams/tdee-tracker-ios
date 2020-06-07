//
//  RecommendedAmountBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct RecAmountBlock: View {

    func getBody() -> some View {
    
        let label = "Recommended daily amount".uppercased()
        
        return HStack {

            Text(label)
                .multilineTextAlignment(.center)
                .frame(width: 84.0)
                .foregroundColor(.white)
                .font(.appEntryRecommendedLabel)
            
            Spacer()
            
            Text("~2843")
                .foregroundColor(.white)
                .font(.appEntryRecommendedAmount)
            Text("KCAL")
                .foregroundColor(.white)
                .font(.appEntryUnit)
        }
        .padding(.horizontal, 36.0)
        .padding(.vertical, 10.0)
    }
    
    var body: some View {
        
        getBody()
    }
}

struct RecAmountBlock_Previews: PreviewProvider {
    static var previews: some View {
        RecAmountBlock().background(Color.appPrimary)
    }
}
