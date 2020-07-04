//
//  SetupBlockTitle.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct SetupBlockTitle: View {

    let title: String
    var paddingTop: CGFloat = 16
    
    var body: some View {

        Text(self.title.uppercased())
            .font(.appCalendarMonth)
            .foregroundColor(.appWhite)
            .frame(height: 20)
            .padding(.top, self.paddingTop)
            .padding(.bottom, 18)
    }
}

struct SetupBlockTitle_Previews: PreviewProvider {
    static var previews: some View {
        SetupBlockTitle(title: "Reminders")
    }
}
