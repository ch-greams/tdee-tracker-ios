//
//  ConfirmationModal.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/30/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct ConfirmationModalSizes {
    
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
    public let descriptionFont: Font = .custom(FontOswald.Light, size: 16)
    
    public let buttonConfirmFont: Font = .custom(FontOswald.Bold, size: 20)
    public let buttonCancelFont: Font = .custom(FontOswald.Regular, size: 16)
}


struct ConfirmationModal: View {
    
    private let sizes = ConfirmationModalSizes()
    
    let fadeColor: Color
    
    let backgroundColor: Color
    let accentColor: Color
    let textColor: Color
    let separatorColor: Color
    
    let confirmLabel: (label: String, enabled: Bool)
    
    let confirmAction: () -> Void
    let cancelAction: () -> Void
    
    var separator: some View {
        return Rectangle()
            .foregroundColor(self.separatorColor)
            .frame(height: self.sizes.separatorHeight)
            .padding(.horizontal, self.sizes.separatorHPadding)
            .padding(.bottom, self.sizes.separatorBPadding)
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            self.fadeColor
                .opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
                
                Text(Label.buyPremiumTitle)
                    .foregroundColor(self.accentColor)
                    .font(self.sizes.titleFont)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, self.sizes.titleVPadding)
                
                self.separator
                
                Text(Label.buyPremiumDescription)
                    .foregroundColor(self.textColor)
                    .font(self.sizes.descriptionFont)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineSpacing(self.sizes.descriptionLineSpacing)
                    .padding(.bottom, self.sizes.descriptionBPadding)
                    .padding(.horizontal, self.sizes.descriptionHPadding)
                
                self.separator
                
                Button(self.confirmLabel.label, action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    self.confirmAction()
                })
                    .buttonStyle(AppDefaultButtonStyle(
                        backgroundColor: self.accentColor,
                        textColor: self.backgroundColor,
                        font: self.sizes.buttonConfirmFont,
                        width: self.sizes.buttonWidth
                    ))
                    .padding(.bottom, self.sizes.buttonConfirmBPadding)
                    .opacity(self.confirmLabel.enabled ? 1 : 0.5)
                    .disabled(!self.confirmLabel.enabled)
                
                Button(Label.cancel, action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    self.cancelAction()
                })
                    .buttonStyle(AppDefaultButtonStyle(
                        backgroundColor: self.backgroundColor,
                        textColor: self.accentColor,
                        withBorder: true,
                        font: self.sizes.buttonCancelFont,
                        width: self.sizes.buttonWidth,
                        height: self.sizes.buttonCancelHeight
                    ))
                    .padding(.bottom, self.sizes.buttonCancelBPadding)
            }
                .frame(maxWidth: .infinity)
                .background(self.backgroundColor)
                .padding(.horizontal, self.sizes.modalHPadding)
                .clipped()
                .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
                
        }
            .padding(.top, self.sizes.modalTPadding)
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
            confirmLabel: (label: "\(Label.buyFor) $3.49", enabled: true),
            confirmAction: { print("\(Label.buyFor) $3.49") },
            cancelAction: { print(Label.cancel) }
        )
    }
}
