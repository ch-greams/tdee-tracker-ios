//
//  SetupBlockTitle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct SetupBlockTitleStyle {
    
    // MARK: - Sizes
    
    public let labelHeight: CGFloat = 20
    public let labelTPadding: CGFloat = 22
    public let labelBPadding: CGFloat = 24
    
    // MARK: - Fonts
    
    public let labelFont: Font = .custom(FontOswald.Medium, size: 24)
}


struct SetupBlockTitle: View {
    
    private let style: SetupBlockTitleStyle = SetupBlockTitleStyle()

    let title: String
    let textColor: Color
    
    var paddingTop: CGFloat?
    
    var body: some View {

        Text(self.title.uppercased())
            .font(self.style.labelFont)
            .foregroundColor(textColor)
            .frame(height: self.style.labelHeight)
            .padding(.top, self.paddingTop ?? self.style.labelTPadding)
            .padding(.bottom, self.style.labelBPadding)
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
