//
//  SetupBlockTitle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct SetupBlockTitle: View {

    let title: String
    let textColor: Color
    
    var paddingTop: CGFloat = 22
    
    var body: some View {

        Text(self.title.uppercased())
            .font(.appCalendarMonth)
            .foregroundColor(textColor)
            .frame(height: 20)
            .padding(.top, self.paddingTop)
            .padding(.bottom, 24)
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
