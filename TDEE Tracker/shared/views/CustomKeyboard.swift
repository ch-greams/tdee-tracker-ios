//
//  CustomKeyboard.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 9/16/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


enum InputName {
    case Weight
    case Food
    case GoalWeight
    case GoalWeeklyWeightDelta
}


struct CustomKeyboardSizes {
    
    // MARK: - Sizes
    
    public let buttonSpacing: CGFloat = 2
    
    public let topBorderHeight: CGFloat = 1
    public let topBorderBPadding: CGFloat = 4
    
    public let backspaceIconSize: CGFloat = 20
    
    public let backgroundBPadding: CGFloat
    
    // MARK: - Fonts

    public let buttonText: Font = .custom(FontOswald.Regular, size: 24)
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.backgroundBPadding = uiSizes.keyboardBottomPadding
    }
}


struct CustomKeyboard: View {
    
    private let sizes = CustomKeyboardSizes(uiSizes: UISizes.current)
    
    @EnvironmentObject var appState: AppState
    
    @Binding var input: String
    
    let symbolLines: [ [ String ] ] = [
        [ "1", "2", "3" ],
        [ "4", "5", "6" ],
        [ "7", "8", "9" ],
        [
            ( Locale.current.decimalSeparator ?? "." ),
            "0",
            "backspace"
        ],
    ]
    
    
    private func getButton(_ symbol: String) -> some View {
        
        if symbol == "backspace" {
            
            return AnyView(
            
                Button(
                    action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        
                        if !self.input.isEmpty {
                            self.input.removeLast()
                        }
                    },
                    label: {
                        Image("backspace-sharp")
                            .resizable()
                            .frame(
                                width: self.sizes.backspaceIconSize,
                                height: self.sizes.backspaceIconSize
                            )
                    }
                )
                    .buttonStyle(KeyboardButtonStyle(
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                        textColor: self.appState.uiTheme.inputAccentColor
                    ))
                    .font(self.sizes.buttonText)
            )
        }
        else {
            
            return AnyView(
                Button(symbol, action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    
                    if self.input.count < 7 {
                        self.input.append(symbol)
                    }
                })
                    .buttonStyle(KeyboardButtonStyle(
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                        textColor: self.appState.uiTheme.inputAccentColor
                    ))
                    .font(self.sizes.buttonText)
            )
        }
    }
    
    private func getButtonsLine(_ line: [ String ]) -> some View {
        
        return (
            HStack(alignment: .center, spacing: self.sizes.buttonSpacing) {
                
                ForEach(line, id: \.self) { symbol in
                 
                    self.getButton(symbol)
                }
            }
        )
    }
    
    var body: some View {
            
        VStack(alignment: .center, spacing: self.sizes.buttonSpacing) {
            
            Rectangle()
                .frame(height: self.sizes.topBorderHeight)
                .foregroundColor(self.appState.uiTheme.navbarAccentColor)
                .opacity(0.5)
                .padding(.bottom, self.sizes.topBorderBPadding)
            
            ForEach(self.symbolLines, id: \.self) { line in
                
                self.getButtonsLine(line)
            }
        }
            .frame(maxWidth: .infinity)
            .padding(.bottom, self.sizes.backgroundBPadding)
            .background(self.appState.uiTheme.backgroundColor)
            .transition(.move(edge: .bottom))
            .animation(.easeOut(duration: 0.16))
    }
}

struct CustomKeyboard_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        CustomKeyboard(input: .constant("72.34"))
            .environmentObject(appState)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
    }
}
