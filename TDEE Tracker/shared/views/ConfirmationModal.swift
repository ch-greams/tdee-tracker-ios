//
//  ConfirmationModal.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/30/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct ConfirmationModalStyle {
    
    // MARK: - Sizes

    public let separatorHeight: CGFloat = 1
    public let separatorHPadding: CGFloat = 16
    public let separatorBPadding: CGFloat = 16

    public let titleVPadding: CGFloat = 16
    
    public let descriptionLineSpacing: CGFloat = 6
    public let descriptionBPadding: CGFloat = 16
    public let descriptionHPadding: CGFloat = 24
    
    public let buttonWidth: CGFloat = 216
    public let buttonConfirmBPadding: CGFloat = 4
    public let buttonCancelHeight: CGFloat = 36
    public let buttonCancelBPadding: CGFloat = 16
    
    public let modalHPadding: CGFloat = 32
    public let modalTPadding: CGFloat = -24
    
    // MARK: - Fonts

    public let titleFont: Font = .custom(FontOswald.Medium, size: 24)
    public let descriptionFont: Font = .custom(FontOswald.Light, size: 18)
    
    public let buttonConfirmFont: Font = .custom(FontOswald.Bold, size: 20)
    public let buttonCancelFont: Font = .custom(FontOswald.Regular, size: 16)
}


struct ConfirmationModal: View {
    
    private let style: ConfirmationModalStyle = ConfirmationModalStyle()
    
    let fadeColor: Color
    
    let backgroundColor: Color
    let accentColor: Color
    let textColor: Color
    let separatorColor: Color
    
    let confirmLabel: String
    
    let confirmAction: () -> Void
    let cancelAction: () -> Void
    
    var separator: some View {
        return Rectangle()
            .foregroundColor(self.separatorColor)
            .frame(height: self.style.separatorHeight)
            .padding(.horizontal, self.style.separatorHPadding)
            .padding(.bottom, self.style.separatorBPadding)
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            self.fadeColor
                .opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
                
                Text(Label.buyPremiumTitle)
                    .foregroundColor(self.accentColor)
                    .font(self.style.titleFont)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, self.style.titleVPadding)
                
                self.separator
                
                Text(Label.buyPremiumDescription)
                    .foregroundColor(self.textColor)
                    .font(self.style.descriptionFont)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineSpacing(self.style.descriptionLineSpacing)
                    .padding(.bottom, self.style.descriptionBPadding)
                    .padding(.horizontal, self.style.descriptionHPadding)
                
                self.separator
                
                Button(self.confirmLabel, action: self.confirmAction)
                    .buttonStyle(AppDefaultButtonStyle(
                        backgroundColor: self.accentColor,
                        textColor: self.backgroundColor,
                        font: self.style.buttonConfirmFont,
                        width: self.style.buttonWidth
                    ))
                    .padding(.bottom, self.style.buttonConfirmBPadding)
                
                Button(Label.cancel, action: self.cancelAction)
                    .buttonStyle(AppDefaultButtonStyle(
                        backgroundColor: self.backgroundColor,
                        textColor: self.accentColor,
                        withBorder: true,
                        font: self.style.buttonCancelFont,
                        width: self.style.buttonWidth,
                        height: self.style.buttonCancelHeight
                    ))
                    .padding(.bottom, self.style.buttonCancelBPadding)
            }
                .frame(maxWidth: .infinity)
                .background(self.backgroundColor)
                .padding(.horizontal, self.style.modalHPadding)
                .clipped()
                .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
                
        }
            .padding(.top, self.style.modalTPadding)
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
            confirmLabel: "\(Label.buyFor) $3.49",
            confirmAction: { print("\(Label.buyFor) $3.49") },
            cancelAction: { print(Label.cancel) }
        )
    }
}
