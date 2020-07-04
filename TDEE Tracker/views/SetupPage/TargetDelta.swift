//
//  TargetSurplus.swift
//  TDEE Tracker
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

            Spacer()
            
            Text("Target \(changeType)".uppercased())
                .frame(width: 114, alignment: .leading)
                .foregroundColor(.appWhite)
                .font(.appInputLabel)

            Spacer()
            
            Text(String(abs(self.value)))
                .foregroundColor(.appWhite)
                .font(.appInputValue)
                .padding(.trailing)

            Text("\(self.unit)/day".uppercased())
                .foregroundColor(.appWhite)
                .font(.appInputLabel)
                
            Spacer()
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
    }
}

struct TargetDelta_Previews: PreviewProvider {
    static var previews: some View {
        TargetDelta(value: 257, unit: "kcal")
            .background(Color.appPrimary)
    }
}

