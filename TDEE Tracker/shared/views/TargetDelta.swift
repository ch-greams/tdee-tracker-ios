//
//  TargetSurplus.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct TargetDeltaSizes {
    
    // MARK: - Sizes
    
    public let valueTPadding: CGFloat
    
    public let bodyHPadding: CGFloat
    
    // MARK: - Fonts

    public let valueFont: Font
    public let unitFont: Font
    
    public let labelFont: Font
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.valueTPadding = scale * 8

        self.valueFont = .custom(FontOswald.Bold, size: scale * 32)
        self.unitFont = .custom(FontOswald.Light, size: scale * 18)
    
        if hasNotch {
            self.bodyHPadding = scale * 28
            self.labelFont = .custom(FontOswald.Light, size: scale * 18)
        }
        else {
            self.bodyHPadding = scale * 20
            self.labelFont = .custom(FontOswald.Light, size: scale * 14)
        }
    }
}


struct TargetDelta: View {
    
    private let sizes = TargetDeltaSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    let value: Int
    let unit: String
    let textColor: Color

    var body: some View {
        
        let changeType = ( self.value > 0 ) ? Label.targetSurplus : Label.targetDeficit
        
        return HStack(alignment: .center, spacing: 0) {
            
            Text(changeType.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(textColor)
                .font(self.sizes.labelFont)
            
            Text(String(abs(self.value)))
                .foregroundColor(textColor)
                .font(self.sizes.valueFont)
                .padding(.trailing, self.sizes.valueTPadding)

            Text("\(self.unit)/\(Label.day)".uppercased())
                .foregroundColor(textColor)
                .font(self.sizes.unitFont)
        }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, self.sizes.bodyHPadding)
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

