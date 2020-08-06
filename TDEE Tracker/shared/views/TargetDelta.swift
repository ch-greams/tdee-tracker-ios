//
//  TargetSurplus.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct TargetDeltaStyle {
    
    // MARK: - Fonts

    public let valueFont: Font = .custom(FontOswald.Bold, size: 32)
    public let unitFont: Font = .custom(FontOswald.Light, size: 18)
    
    public let labelFont: Font
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.labelFont = .custom(FontOswald.Light, size: uiSizes.setupInputLabelFontSize)
    }
}


struct TargetDelta: View {
    
    private let style: TargetDeltaStyle = TargetDeltaStyle(uiSizes: UISizes.current)
    
    let value: Int
    let unit: String
    let textColor: Color

    var body: some View {
        
        let changeType = ( self.value > 0 ) ? Label.targetSurplus : Label.targetDeficit
        
        return HStack(alignment: .center, spacing: 0) {
            
            Text(changeType.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(textColor)
                .font(self.style.labelFont)
            
            Text(String(abs(self.value)))
                .foregroundColor(textColor)
                .font(self.style.valueFont)
                .padding(.trailing)

            Text("\(self.unit)/\(Label.day)".uppercased())
                .foregroundColor(textColor)
                .font(self.style.unitFont)
        }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
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

