//
//  AlertMessage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/29/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct AlertMessage: View {
    
    let text: String
    
    let textColor: Color
    let backgroundColor: Color
    
    let closeAction: () -> Void
    
    var body: some View {
        
        HStack {

            Text(self.text)
                .multilineTextAlignment(.center)
                .foregroundColor(self.textColor)
                .font(.appWarningText)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background(self.backgroundColor)
            .onTapGesture(perform: self.closeAction)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
    }
}

struct AlertMessage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        VStack(alignment: .center, spacing: 16) {
            
            AlertMessage(
                text: "Some Message".uppercased(),
                textColor: UIThemeManager.DEFAULT.mainTextColor,
                backgroundColor: UIThemeManager.DEFAULT.warningBackgroundColor,
                closeAction: { print("closeAction") }
            )
            
            AlertMessage(
                text: "Purchase of Test Item failed.\nError: Cannot connect to iTunes Store.".uppercased(),
                textColor: UIThemeManager.DEFAULT.mainTextColor,
                backgroundColor: UIThemeManager.DEFAULT.warningBackgroundColor,
                closeAction: { print("closeAction") }
            )
                
        }
            .environmentObject(appState)
    }
}

