//
//  InputNumber.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct InputNumberSizes {
    
    // MARK: - Sizes
    
    public let inputWidth: CGFloat
    public let inputHeight: CGFloat
    public let inputTPadding: CGFloat
    public let inputHPadding: CGFloat
    public let inputFontTPadding: CGFloat
    
    public let unitWidth: CGFloat
    
    public let iconCheckmarkSize: CGFloat
    public let buttonCheckmarkWidth: CGFloat
    
    public let bodyVPadding: CGFloat
    public let bodyHPadding: CGFloat
    
    public let bodyHeight: CGFloat
    
    // MARK: - Fonts

    public let valueFont: Font
    public let unitFont: Font
    
    public let labelFont: Font

    // MARK: - Init

    init(hasNotch: Bool, scale: CGFloat) {

        self.inputWidth = scale * 116
        self.inputTPadding = scale * 8
        self.inputHPadding = scale * 8
        self.inputFontTPadding = scale * -2
    
        self.unitWidth = scale * 40
    
        self.iconCheckmarkSize = scale * 36
        self.buttonCheckmarkWidth = scale * 100
    
        self.bodyVPadding = scale * 1
        self.bodyHPadding = 8


        self.unitFont = .custom(FontOswald.Light, size: scale * 18)

        if hasNotch {
            self.bodyHeight = scale * 74
            self.labelFont = .custom(FontOswald.Light, size: scale * 16)
            self.valueFont = .custom(FontOswald.Bold, size: scale * 28)
            self.inputHeight = scale * 40
        }
        else {
            self.bodyHeight = scale * 58
            self.labelFont = .custom(FontOswald.Light, size: scale * 14)
            self.valueFont = .custom(FontOswald.Bold, size: scale * 24)
            self.inputHeight = scale * 34
        }
    }
}
    
    
struct InputNumber: View {
    
    private let sizes = InputNumberSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    let title: String
    let unit: String
    let input: Binding<String>
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

        HStack(alignment: .center, spacing: 0) {

            if !self.isOpen {
                Text(self.title.uppercased())
                    .font(self.sizes.labelFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(self.accentColor)
                    .padding(.leading)
            }
            
            Spacer()

            HStack(alignment: .center, spacing: 0) {
                Text(self.input.wrappedValue)
                    .font(self.sizes.valueFont)
                    .padding(.top, self.sizes.inputFontTPadding)
                    .padding(.trailing, self.sizes.inputTPadding)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .frame(width: self.sizes.inputWidth, height: self.sizes.inputHeight, alignment: .trailing)
                    .background(self.isSelected ? self.backgroundSelectedColor : self.backgroundColor)
                    .border(self.accentColor)
                    .foregroundColor(self.accentColor)
                    .padding(.horizontal, self.sizes.inputHPadding)
                    .onTapGesture(perform: self.openInput)
                
                Text(self.unit)
                    .font(self.sizes.unitFont)
                    .frame(width: self.sizes.unitWidth, alignment: .leading)
                    .foregroundColor(self.accentColor)
            }
            
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



struct InputNumber_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 8) {
                
                InputNumber(
                    title: Label.todaysWeight,
                    unit: WeightUnit.kg.localized,
                    input: .constant("17.4"),
                    onCommit: { print("onCommit") },
                    openInput: { print("openInput") },
                    isOpen: false,
                    isSelected: false,
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundSelectedColor: UIThemeManager.DEFAULT.calendarWeekHighlight,
                    confirmButtonColor: UIThemeManager.DEFAULT.inputConfirmButtonColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
                
                InputNumber(
                    title: "Title",
                    unit: WeightUnit.kg.localized,
                    input: .constant("17.4"),
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
