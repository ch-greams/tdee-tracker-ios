//
//  ConfirmationModal.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/30/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct ConfirmationModal: View {
    
    let fadeColor: Color
    
    let backgroundColor: Color
    let accentColor: Color
    let textColor: Color
    let separatorColor: Color
    
    let confirmAction: () -> Void
    let cancelAction: () -> Void
    
    var separator: some View {
        return Rectangle()
            .foregroundColor(self.separatorColor)
            .frame(height: 1)
            .padding(.horizontal, 16)
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            self.fadeColor
                .opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
                
                Text(Label.buyPremiumTitle)
                    .foregroundColor(self.accentColor)
                    .font(.appSetupPremiumTitle)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                
                self.separator
                    .padding(.bottom, 16)
                
                Text(Label.buyPremiumDescriptionPartOne)
                    .foregroundColor(self.textColor)
                    .font(.appSetupPremiumHint)
                    
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 24)
                    
                Text(Label.buyPremiumDescriptionPartTwo)
                    .foregroundColor(self.textColor)
                    .font(.appSetupPremiumHint)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 24)
                
                self.separator
                    .padding(.bottom, 16)
                
                Button(Label.buy, action: self.confirmAction)
                    .buttonStyle(AppDefaultButtonStyle(
                        backgroundColor: self.accentColor,
                        textColor: self.backgroundColor,
                        font: .appSetupPremiumBuy,
                        width: 216
                    ))
                    .padding(.bottom, 4)
                
                Button(Label.cancel, action: self.cancelAction)
                    .buttonStyle(AppDefaultButtonStyle(
                        backgroundColor: self.backgroundColor,
                        textColor: self.accentColor,
                        withBorder: true,
                        font: .appSetupPremiumCancel,
                        width: 216,
                        height: 36
                    ))
                    .padding(.bottom, 16)
            }
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(self.backgroundColor)
                .padding(.horizontal, 32)
                .clipped()
                .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
                
        }
            .padding(.top, -24)
    }
}

struct ConfirmationModal_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationModal(
            fadeColor: UIThemeManager.DEFAULT.backgroundColor,
            backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
            accentColor: UIThemeManager.DEFAULT.secondaryTextColor,
            textColor: UIThemeManager.DEFAULT.calendarTextDefaultColor,
            separatorColor: UIThemeManager.DEFAULT.trendsSeparatorColor,
            confirmAction: { print(Label.buy) },
            cancelAction: { print(Label.cancel) }
        )
    }
}
