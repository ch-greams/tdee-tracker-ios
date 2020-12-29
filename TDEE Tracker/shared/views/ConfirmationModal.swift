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

    public let separatorHeight: CGFloat
    public let separatorHPadding: CGFloat
    public let separatorBPadding: CGFloat

    public let titleVPadding: CGFloat
    
    public let descriptionLineSpacing: CGFloat
    public let descriptionBPadding: CGFloat
    public let descriptionHPadding: CGFloat
    
    public let buttonWidth: CGFloat
    public let buttonConfirmBPadding: CGFloat
    public let buttonCancelHeight: CGFloat
    public let buttonCancelBPadding: CGFloat
    
    public let modalHPadding: CGFloat
    public let modalTPadding: CGFloat
    
    // MARK: - Fonts

    public let titleFont: Font
    public let descriptionFont: Font
    
    public let buttonConfirmFont: Font
    public let buttonCancelFont: Font

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {

        self.separatorHeight = scale * 1
        self.separatorHPadding = scale * 16
        self.separatorBPadding = scale * 16

        self.titleVPadding = scale * 16
        
        self.descriptionLineSpacing = scale * 6
        self.descriptionBPadding = scale * 16
        self.descriptionHPadding = scale * 24
        
        self.buttonWidth = scale * 216
        self.buttonConfirmBPadding = scale * 4
        self.buttonCancelHeight = scale * 36
        self.buttonCancelBPadding = scale * 16
        
        self.modalHPadding = scale * 32
        self.modalTPadding = scale * -24

        self.titleFont = .custom(FontOswald.Medium, size: scale * 24)
        self.descriptionFont = .custom(FontOswald.Light, size: scale * 16)
        
        self.buttonConfirmFont = .custom(FontOswald.Bold, size: scale * 20)
        self.buttonCancelFont = .custom(FontOswald.Regular, size: scale * 16)
    }
}


struct ConfirmationModal: View {
    
    private let sizes = ConfirmationModalSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
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
