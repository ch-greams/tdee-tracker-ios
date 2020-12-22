//
//  InputToggle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct InputToggleSizes {
    
    // MARK: - Sizes
    
    public let buttonsHSpacing: CGFloat
    public let buttonsPadding: CGFloat
    
    public let bodyVPadding: CGFloat
    public let bodyHPadding: CGFloat
    
    public let bodyHeight: CGFloat
    
    // MARK: - Fonts

    public let labelFont: Font

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.buttonsHSpacing = scale * 1
        self.buttonsPadding = scale * 1
    
        self.bodyVPadding = scale * 1
        self.bodyHPadding = 8

        self.labelFont = .custom(FontOswald.Light, size: scale * 18)

        if hasNotch {
            self.bodyHeight = scale * 74
        }
        else {
            self.bodyHeight = scale * 58
        }
    }
}


struct InputToggle<T>: View where T:Equatable, T:Localizable {
    
    private let sizes = InputToggleSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    let title: String
    let setValue: (T) -> Void
    let first: T
    let second: T
    let selected: Optional<T>
    let backgroundColor: Color
    let accentColor: Color
    
    @State private var animation: Animation? = nil
    
    
    var body: some View {

        let firstButton = Button(
            first.localized,
            action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                self.setValue(self.first)
            }
        )
            .buttonStyle(InputToggleButtonStyle(
                isSelected: selected == first,
                backgroundColor: backgroundColor,
                accentColor: accentColor
            ))
        
        let secondButton = Button(
            second.localized,
            action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                self.setValue(self.second)
            }
        )
            .buttonStyle(InputToggleButtonStyle(
                isSelected: selected == second,
                backgroundColor: backgroundColor,
                accentColor: accentColor
            ))

        
        return HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(self.sizes.labelFont)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(accentColor)
                .padding(.leading)
            
            Spacer()
            
            HStack(alignment: .center, spacing: self.sizes.buttonsHSpacing) {

                firstButton

                secondButton
            }
                .padding(self.sizes.buttonsPadding)
                .background(accentColor)
                .padding(.horizontal)
        }
            .animation(self.animation)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: self.sizes.bodyHeight)
            .background(backgroundColor)
            .padding(.vertical, self.sizes.bodyVPadding)
            .padding(.horizontal, self.sizes.bodyHPadding)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
            .onAppear {
                DispatchQueue.main.async { self.animation = .default }
            }
    }
}


struct InputToggle_Previews: PreviewProvider {

    static var previews: some View {

        ZStack {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 8) {
             
                InputToggle(
                    title: Label.energy,
                    setValue: { print($0) },
                    first: EnergyUnit.kcal,
                    second: EnergyUnit.kj,
                    selected: EnergyUnit.kcal,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
            }
        }
    }
}
