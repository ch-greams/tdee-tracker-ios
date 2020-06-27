//
//  TargetSurplus.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct TargetDelta: View {
    
    let value: Int
    let unit: String
    

    var body: some View {
        
        let changeType = ( self.value > 0 ) ? "surplus" : "deficit"
        
        return HStack(alignment: .center, spacing: 0) {

            Text("Target \(changeType)".uppercased())
                .frame(width: 114, alignment: .leading)
                .foregroundColor(.white)
                .font(.appTrendsItemLabel)
                .padding(.leading, 32)
                .padding(.trailing, 50)
            
            Text(String(abs(self.value)))
                .foregroundColor(.white)
                .font(.appTrendsItemValue)
                .padding(.trailing, 16)

            Text("\(self.unit)/day".uppercased())
                .foregroundColor(.white)
                .font(.appTrendsItemLabel)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .frame(height: 40)
            .padding(.vertical, 15)
    }
}

struct TargetDelta_Previews: PreviewProvider {
    static var previews: some View {
        TargetDelta(value: 257, unit: "kcal")
            .background(Color.appPrimary)
    }
}

