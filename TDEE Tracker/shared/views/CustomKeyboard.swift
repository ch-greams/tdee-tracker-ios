//
//  CustomKeyboard.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 9/16/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


enum InputName {
    case Weight, Food
    case GoalWeight, GoalWeeklyWeightDelta

    case ReminderWeightDate, ReminderFoodDate
    
    public var keyboardType: KeyboardType {
        
        switch self {
            case InputName.Weight,
                 InputName.Food,
                 InputName.GoalWeight,
                 InputName.GoalWeeklyWeightDelta:
                
                return KeyboardType.Number
                
            case InputName.ReminderWeightDate,
                 InputName.ReminderFoodDate:

                return KeyboardType.Time
        }
    }
}

enum KeyboardType {
    case Number
    case Time
}


struct CustomKeyboardSizes {
    
    // MARK: - Sizes
    
    public let buttonSpacing: CGFloat
    
    public let topBorderHeight: CGFloat
    public let topBorderBPadding: CGFloat
    
    public let backspaceIconSize: CGFloat
    
    public let textOffsetTPadding: CGFloat
    
    public let backgroundBPadding: CGFloat
    
    // MARK: - Fonts

    public let buttonText: Font
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.buttonSpacing = scale * 2
    
        self.topBorderHeight = scale * 1
        self.topBorderBPadding = scale * 4
    
        self.backspaceIconSize = scale * 24
    
        self.textOffsetTPadding = scale * -2

        if hasNotch {
            self.backgroundBPadding = scale * 40
            self.buttonText = .custom(FontOswald.Regular, size: scale * 24)
        }
        else {
            self.backgroundBPadding = scale * 6
            self.buttonText = .custom(FontOswald.Regular, size: scale * 20)
        }
    }
}


struct CustomKeyboard: View {
    
    private let sizes = CustomKeyboardSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    @EnvironmentObject var appState: AppState
    
    let BACKSPACE_BTN_LABEL = "backspace"
    let MERIDIEM_BTN_LABEL = "AM/PM"
    
    let AM_LABEL = "AM"
    let PM_LABEL = "PM"
    
    let type: KeyboardType
    
    @Binding var input: String
    
    var maxLength: Int {
        
        switch self.type {
            case KeyboardType.Number:
                return 7
            case KeyboardType.Time:
                return 4
        }
    }
    
    var specialButton: String {
        
        switch self.type {
            case KeyboardType.Number:
                return ( Locale.current.decimalSeparator ?? "." )
            case KeyboardType.Time:
                let elements = Utils.getTimeElementsFromString(self.input)
                return elements.meridiem.isEmpty ? "" : self.MERIDIEM_BTN_LABEL
        }
    }
    
    var symbolLines: [ [ String ] ] {
        
        return [
            [ "1", "2", "3" ],
            [ "4", "5", "6" ],
            [ "7", "8", "9" ],
            [
                self.specialButton,
                "0",
                self.BACKSPACE_BTN_LABEL
            ],
        ]
    }
    
    
    // MARK: - ButtonActions
    
    private func getNumberButtonAction(symbol: String) -> () -> Void {
        
        return {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            switch symbol {
                case self.BACKSPACE_BTN_LABEL:
                    if !self.input.isEmpty {
                        self.input.removeLast()
                    }
                default:
                    if self.input.count < self.maxLength {
                        self.input.append(symbol)
                    }
            }
        }
    }
    
    private func getTimeButtonAction(symbol: String) -> () -> Void {
        
        return {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            let elements = Utils.getTimeElementsFromString(self.input)
            
            switch symbol {
                case self.BACKSPACE_BTN_LABEL:
                    
                    let timeString = "\(elements.hours)\(elements.minutes)"

                    if !timeString.isEmpty {
                        
                        let newTimeString = timeString.dropLast()
                        
                        let minutes = newTimeString.suffix(2)
                        let hours = newTimeString.prefix(upTo: minutes.startIndex)
                        
                        let hoursInt = Int(hours) ?? 0
                        let minutesInt = Int(minutes) ?? 0
                        
                        self.input = (
                            elements.meridiem.isEmpty
                                ? String(format: "%02d:%02d", hoursInt, minutesInt)
                                : "\(String(format: "%01d:%02d", hoursInt, minutesInt)) \(elements.meridiem)"
                        )
                    }
                case self.MERIDIEM_BTN_LABEL:
                    
                    if !elements.meridiem.isEmpty {
                        
                        let newMeridiem = ( elements.meridiem == self.AM_LABEL ) ? self.PM_LABEL : self.AM_LABEL
                        
                        self.input = "\(elements.hours):\(elements.minutes) \(newMeridiem)"
                    }
                    
                default:
                    
                    if let number = Int("\(elements.hours)\(elements.minutes)"),
                       String(number).count < self.maxLength {
                        
                        let newTimeString = "\(number)\(symbol)"
                        
                        let minutes = newTimeString.suffix(2)
                        let hours = newTimeString.prefix(upTo: minutes.startIndex)
                        
                        let hoursInt = Int(hours) ?? 0
                        let minutesInt = Int(minutes) ?? 0
                        
                        self.input = (
                            elements.meridiem.isEmpty
                                ? String(format: "%02d:%02d", hoursInt, minutesInt)
                                : "\(String(format: "%01d:%02d", hoursInt, minutesInt)) \(elements.meridiem)"
                        )
                    }
            }
        }
    }
    
    private func getButtonAction(symbol: String) -> () -> Void {
    
        switch self.type {
            case KeyboardType.Number:
                return self.getNumberButtonAction(symbol: symbol)
            case KeyboardType.Time:
                return self.getTimeButtonAction(symbol: symbol)
        }
    }
    
    // MARK: - Button UI
    
    private func getButton(_ symbol: String) -> some View {
        
        Button(
            action: self.getButtonAction(symbol: symbol),
            label: {
                if symbol == self.BACKSPACE_BTN_LABEL {

                    Image("backspace-sharp")
                        .resizable()
                        .frame(
                            width: self.sizes.backspaceIconSize,
                            height: self.sizes.backspaceIconSize
                        )
                }
                else {
                    Text(symbol).padding(.top, self.sizes.textOffsetTPadding)
                }
            }
        )
            .buttonStyle(KeyboardButtonStyle(
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                textColor: self.appState.uiTheme.inputAccentColor
            ))
            .font(self.sizes.buttonText)
    }
    
    private func getButtonsLine(_ line: [ String ]) -> some View {
        
        HStack(alignment: .center, spacing: self.sizes.buttonSpacing) {
            
            ForEach(line, id: \.self) { symbol in
             
                self.getButton(symbol)
            }
        }
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
            .transition(
                AnyTransition.opacity
                    .animation(
                        .easeInOut(duration: 0.4)
                    )
            )
    }
}

struct CustomKeyboard_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        CustomKeyboard(
            type: KeyboardType.Number,
            input: .constant("72.34")
        )
            .environmentObject(appState)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
    }
}
