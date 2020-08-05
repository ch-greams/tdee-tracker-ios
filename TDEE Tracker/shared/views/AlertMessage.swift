//
//  AlertMessage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/29/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct AlertMessageStyle {
    
    // MARK: - Sizes
    
    public let bodyInsideVPadding: CGFloat = 16
    public let bodyInsideHPadding: CGFloat = 32
    
    public let bodyOutsideVPadding: CGFloat = 1
    public let bodyOutsideHPadding: CGFloat = 8
    
    // MARK: - Fonts

    public let warningText: Font = .custom(FontOswald.Medium, size: 16)
}


struct AlertMessage: View {
    
    private let style: AlertMessageStyle = AlertMessageStyle()
    
    let text: String
    
    let textColor: Color
    let backgroundColor: Color
    
    let closeAction: () -> Void
    
    var body: some View {
        
        HStack {

            Text(self.text)
                .multilineTextAlignment(.center)
                .foregroundColor(self.textColor)
                .font(self.style.warningText)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.vertical, self.style.bodyInsideVPadding)
            .padding(.horizontal, self.style.bodyInsideHPadding)
            .background(self.backgroundColor)
            .onTapGesture(perform: self.closeAction)
            .padding(.vertical, self.style.bodyOutsideVPadding)
            .padding(.horizontal, self.style.bodyOutsideHPadding)
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
                text: Label.notAuthorized.uppercased(),
                textColor: UIThemeManager.DEFAULT.mainTextColor,
                backgroundColor: UIThemeManager.DEFAULT.warningBackgroundColor,
                closeAction: { print("closeAction") }
            )
                
        }
            .environmentObject(appState)
    }
}

