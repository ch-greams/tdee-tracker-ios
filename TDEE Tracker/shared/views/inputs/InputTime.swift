//
//  InputTime.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 9/17/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct InputTimeSizes {
    
    // MARK: - Sizes
    
    public let inputWidth: CGFloat
    public let inputHeight: CGFloat
    
    public let inputHPadding: CGFloat
    
    public let inputFontOffsetTPadding: CGFloat
    public let inputFontOffsetLPadding: CGFloat
    
    public let timeHSpacing: CGFloat
    public let meridiemWidth: CGFloat
    
    public let iconCheckmarkSize: CGFloat
    public let buttonCheckmarkWidth: CGFloat
    
    public let bodyVPadding: CGFloat
    public let bodyHPadding: CGFloat
    
    public let bodyHeight: CGFloat
    
    // MARK: - Fonts

    public let timeFont: Font
    public let meridiemFont: Font
    
    public let labelFont: Font

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.inputWidth = scale * 108
    
        self.inputHPadding = scale * 16
    
        self.inputFontOffsetTPadding = scale * -2
        self.inputFontOffsetLPadding = scale * 4
    
        self.timeHSpacing = scale * 2
        self.meridiemWidth = scale * 48
    
        self.iconCheckmarkSize = scale * 36
        self.buttonCheckmarkWidth = scale * 100
    
        self.bodyVPadding = scale * 1
        self.bodyHPadding = 8

        self.timeFont = .custom(FontOswald.Bold, size: scale * 28)
        self.meridiemFont = .custom(FontOswald.Bold, size: scale * 18)

        if hasNotch {
            self.bodyHeight = scale * 74
            self.labelFont = .custom(FontOswald.Light, size: scale * 18)
            self.inputHeight = scale * 40
        }
        else {
            self.bodyHeight = scale * 58
            self.labelFont = .custom(FontOswald.Light, size: scale * 14)
            self.inputHeight = scale * 34
        }
    }
}
    
    
struct InputTime: View {
    
    private let sizes = InputTimeSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    let title: String
    let inputValue: String
    let onCommit: () -> Void
    let openInput: () -> Void
    let isOpen: Bool
    let isSelected: Bool
    
    let backgroundColor: Color
    let backgroundSelectedColor: Color
    let confirmButtonColor: Color
    let accentColor: Color
    
    @State private var animation: Animation? = nil
    
    
    var body: some View {
        
        let value = Utils.getTimeElementsFromString(self.inputValue)
        
        let inputWidth = (
            value.meridiem.isEmpty
                ? self.sizes.inputWidth + self.sizes.timeHSpacing + self.sizes.meridiemWidth
                : self.sizes.inputWidth
        )
        
        return HStack(alignment: .center, spacing: 0) {

            if !self.isOpen {
                Text(self.title.uppercased())
                    .font(self.sizes.labelFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(self.accentColor)
                    .padding(.leading, self.sizes.inputHPadding)
            }
            
            Spacer()

            HStack(alignment: .center, spacing: self.sizes.timeHSpacing) {

                Text("\(value.hours):\(value.minutes)")
                    .font(self.sizes.timeFont)
                    .padding(.top, self.sizes.inputFontOffsetTPadding)
                    .padding(.leading, self.sizes.inputFontOffsetLPadding)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .frame(
                        width: inputWidth,
                        height: self.sizes.inputHeight,
                        alignment: .center
                    )
                    .background(self.isSelected ? self.backgroundSelectedColor : self.backgroundColor)
                    .border(self.accentColor)
                    .foregroundColor(self.accentColor)
                
                if !value.meridiem.isEmpty {
                    
                    Text(value.meridiem.uppercased())
                        .font(self.sizes.meridiemFont)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(
                            width: self.sizes.meridiemWidth,
                            height: self.sizes.inputHeight,
                            alignment: .center
                        )
                        .foregroundColor(self.accentColor)
                        .background(self.isSelected ? self.backgroundSelectedColor : self.backgroundColor)
                        .border(self.accentColor)
                }
            }
                .padding(.trailing, self.isOpen ? 0 : self.sizes.inputHPadding)
                .onTapGesture(perform: self.openInput)
            
            if self.isOpen {
                
                Spacer()
            }
            
            Button(
                action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    self.onCommit()
                },
                label: {
                    Image("checkmark-sharp")
                        .resizable()
                        .frame(
                            width: self.isOpen ? self.sizes.iconCheckmarkSize : 0,
                            height: self.sizes.iconCheckmarkSize
                        )
                        .foregroundColor(self.backgroundColor)
                        .clipped()
                        .frame(
                            maxWidth: self.isOpen ? self.sizes.buttonCheckmarkWidth : 0,
                            maxHeight: .infinity
                        )
                        .background(self.confirmButtonColor)
                }
            )

        }
            .animation(self.animation)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: self.sizes.bodyHeight)
            .background(self.backgroundColor)
            .padding(.vertical, self.sizes.bodyVPadding)
            .padding(.horizontal, self.sizes.bodyHPadding)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
            .onAppear {
                DispatchQueue.main.async { self.animation = .default }
            }
    }
}



struct InputTime_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 8) {
                
                InputTime(
                    title: Label.weight,
                    inputValue: Date().timeString,
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: false,
                    isSelected: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundSelectedColor: UIThemeManager.DEFAULT.calendarWeekHighlight,
                    confirmButtonColor: UIThemeManager.DEFAULT.inputConfirmButtonColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
                
                InputTime(
                    title: Label.food,
                    inputValue: Date().timeString,
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: true,
                    isSelected: true,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundSelectedColor: UIThemeManager.DEFAULT.calendarWeekHighlight,
                    confirmButtonColor: UIThemeManager.DEFAULT.inputConfirmButtonColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
            }
        }
    }
}
