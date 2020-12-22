//
//  SetupBlockTitle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct SetupBlockTitleSizes {
    
    // MARK: - Sizes
    
    public let labelHeight: CGFloat
    public let labelTPadding: CGFloat
    public let labelBPadding: CGFloat
    
    // MARK: - Fonts
    
    public let labelFont: Font

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {

        self.labelHeight = scale * 20
        self.labelTPadding = scale * 22
        self.labelBPadding = scale * 24
        
        self.labelFont = .custom(FontOswald.Medium, size: scale * 24)
    }
}


struct SetupBlockTitle: View {
    
    private let sizes = SetupBlockTitleSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)

    let title: String
    let textColor: Color
    
    var paddingTop: CGFloat?
    
    var body: some View {

        Text(self.title.uppercased())
            .font(self.sizes.labelFont)
            .foregroundColor(textColor)
            .frame(height: self.sizes.labelHeight)
            .padding(.top, self.paddingTop ?? self.sizes.labelTPadding)
            .padding(.bottom, self.sizes.labelBPadding)
    }
}

struct SetupBlockTitle_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            SetupBlockTitle(
                title: Label.reminders,
                textColor: UIThemeManager.DEFAULT.mainTextColor
            )
        }
    }
}
