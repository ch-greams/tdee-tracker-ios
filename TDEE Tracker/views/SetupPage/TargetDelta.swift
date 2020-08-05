//
//  TargetSurplus.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct TargetDeltaStyle {
    
    // MARK: - Sizes
    
    public let labelWidth: CGFloat = 134
    
    // MARK: - Fonts

    public let labelFont: Font = .custom(FontOswald.Light, size: 18)
    public let valueFont: Font = .custom(FontOswald.Bold, size: 32)
    public let unitFont: Font = .custom(FontOswald.Light, size: 18)
}


struct TargetDelta: View {
    
    private let style: TargetDeltaStyle = TargetDeltaStyle()
    
    let value: Int
    let unit: String
    let textColor: Color

    var body: some View {
        
        let changeType = ( self.value > 0 ) ? Label.targetSurplus : Label.targetDeficit
        
        return HStack(alignment: .center, spacing: 0) {

            Spacer()
            
            Text(changeType.uppercased())
                .frame(width: self.style.labelWidth, alignment: .leading)
                .foregroundColor(textColor)
                .font(self.style.labelFont)

            Spacer()
            
            Text(String(abs(self.value)))
                .foregroundColor(textColor)
                .font(self.style.valueFont)
                .padding(.trailing)

            Text("\(self.unit)/\(Label.day)".uppercased())
                .foregroundColor(textColor)
                .font(self.style.unitFont)
                
            Spacer()
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
    }
}

struct TargetDelta_Previews: PreviewProvider {

    static var previews: some View {

        TargetDelta(
            value: 257,
            unit: EnergyUnit.kcal.localized,
            textColor: UIThemeManager.DEFAULT.mainTextColor
        )
            .background(UIThemeManager.DEFAULT.backgroundColor)
    }
}

