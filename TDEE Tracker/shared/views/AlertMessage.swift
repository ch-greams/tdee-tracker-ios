//
//  AlertMessage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/29/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct AlertMessageSizes {
    
    // MARK: - Sizes
    
    public let bodyInsideVPadding: CGFloat
    public let bodyInsideHPadding: CGFloat
    
    public let bodyOutsideVPadding: CGFloat
    public let bodyOutsideHPadding: CGFloat
    
    // MARK: - Fonts

    public let warningText: Font

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {

        self.bodyInsideVPadding = scale * 16
        self.bodyInsideHPadding = scale * 32
    
        self.bodyOutsideVPadding = scale * 1
        self.bodyOutsideHPadding = scale * 8

        self.warningText = .custom(FontOswald.Medium, size: scale * 16)
    }
}


struct AlertMessage: View {
    
    private let sizes = AlertMessageSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    let text: String
    
    let textColor: Color
    let backgroundColor: Color
    
    let closeAction: () -> Void
    
    var body: some View {
        
        HStack {

            Text(self.text)
                .multilineTextAlignment(.center)
                .foregroundColor(self.textColor)
                .font(self.sizes.warningText)
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.vertical, self.sizes.bodyInsideVPadding)
            .padding(.horizontal, self.sizes.bodyInsideHPadding)
            .background(self.backgroundColor)
            .onTapGesture(perform: self.closeAction)
            .padding(.vertical, self.sizes.bodyOutsideVPadding)
            .padding(.horizontal, self.sizes.bodyOutsideHPadding)
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

