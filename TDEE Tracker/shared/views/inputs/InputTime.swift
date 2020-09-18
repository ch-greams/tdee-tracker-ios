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
    
    public let inputWidth: CGFloat = 116
    public let inputHeight: CGFloat = 44
    
    public let inputHPadding: CGFloat = 16
    
    public let inputFontOffsetTPadding: CGFloat = -2
    public let inputFontOffsetLPadding: CGFloat = 4
    
    public let timeHSpacing: CGFloat = 2
    public let meridiemWidth: CGFloat = 48
    
    public let iconCheckmarkSize: CGFloat = 40
    public let buttonCheckmarkWidth: CGFloat = 120
    
    public let bodyVPadding: CGFloat = 1
    public let bodyHPadding: CGFloat = 8
    
    public let bodyHeight: CGFloat
    
    // MARK: - Fonts

    public let timeFont: Font = .custom(FontOswald.Bold, size: 32)
    public let meridiemFont: Font = .custom(FontOswald.Bold, size: 18)
    
    public let labelFont: Font

    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.bodyHeight = uiSizes.setupInputHeight
        
        self.labelFont = .custom(FontOswald.Light, size: uiSizes.setupInputLabelFontSize)
    }
}
    
    
struct InputTime: View {
    
    private let sizes = InputTimeSizes(uiSizes: UISizes.current)
    
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
