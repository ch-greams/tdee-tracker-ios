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
    
    public let inputWidth: CGFloat = 124
    public let inputHeight: CGFloat = 44
    public let inputTPadding: CGFloat = 8
    public let inputHPadding: CGFloat = 8
    
    public let unitWidth: CGFloat = 40
    
    public let iconCheckmarkSize: CGFloat = 40
    public let buttonCheckmarkWidth: CGFloat = 120
    
    public let bodyVPadding: CGFloat = 1
    public let bodyHPadding: CGFloat = 8
    
    public let bodyHeight: CGFloat
    
    // MARK: - Fonts

    public let valueFont: Font = .custom(FontOswald.Bold, size: 32)
    public let unitFont: Font = .custom(FontOswald.Light, size: 18)
    
    public let labelFont: Font

    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.bodyHeight = uiSizes.setupInputHeight
        
        self.labelFont = .custom(FontOswald.Light, size: uiSizes.setupInputLabelFontSize)
    }
}
    
    
struct InputNumber: View {
    
    private let sizes = InputNumberSizes(uiSizes: UISizes.current)
    
    let title: String
    let unit: String
    let input: Binding<String>
    let onCommit: () -> Void
    let openInput: () -> Void
    let isOpen: Bool
    
    let backgroundColor: Color
    let backgroundColorName: String
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
                TextField("", text: self.input, onCommit: self.onCommit)
                    .font(self.sizes.valueFont)
                    .padding(.trailing, self.sizes.inputTPadding)
                    .frame(width: self.sizes.inputWidth, height: self.sizes.inputHeight)
                    .border(self.accentColor)
                    .foregroundColor(self.accentColor)
                    .padding(.horizontal, self.sizes.inputHPadding)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
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
                action: self.onCommit,
                label: {
                    CustomImage(
                        name: "checkmark-sharp",
                        colorName: self.backgroundColorName
                    )
                        .frame(minWidth: 0, maxWidth: self.sizes.iconCheckmarkSize)
                        .frame(minHeight: 0, maxHeight: self.sizes.iconCheckmarkSize)
                        .clipped()
                        .frame(maxHeight: .infinity)
                        .frame(maxWidth: self.isOpen ? self.sizes.buttonCheckmarkWidth : 0)
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
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundColorName: UIThemeManager.DEFAULT.inputBackgroundColorName,
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
                    backgroundColor: UIThemeManager.DEFAULT.inputBackgroundColor,
                    backgroundColorName: UIThemeManager.DEFAULT.inputBackgroundColorName,
                    confirmButtonColor: UIThemeManager.DEFAULT.inputConfirmButtonColor,
                    accentColor: UIThemeManager.DEFAULT.inputAccentColor
                )
            }
        }
    }
}
