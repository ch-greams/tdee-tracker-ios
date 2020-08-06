//
//  SetupRemindersBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct SetupRemindersBlockSizes {
    
    // MARK: - Sizes
    
    public let datePickerPadding: CGFloat = 8
    
    // MARK: - Fonts
    
    public let datePickerFont: Font = .custom(FontOswald.Bold, size: 32)
}


struct SetupRemindersBlock: View {
    
    private let sizes = SetupRemindersBlockSizes()
    
    @EnvironmentObject var appState: AppState
    
    @State private var selectedInput = ReminderType.Weight
    
    @Binding var isOpen: Bool
    
    func getDateInputValue(type: ReminderType) -> Binding<Date> {
        
        switch type {
            case ReminderType.Weight:
                return self.$appState.reminderWeightDate
            case ReminderType.Food:
                return self.$appState.reminderFoodDate
        }
    }

    
    var body: some View {
        
        let doneAction = {
            self.isOpen = false
            self.appState.updateReminders(self.selectedInput)
        }
        
        return VStack(alignment: .center, spacing: 0) {

            SetupBlockTitle(
                title: Label.reminders,
                textColor: self.appState.uiTheme.mainTextColor
            )
            
            if !self.isOpen || self.selectedInput == ReminderType.Weight {
                
                InputSelectButton(
                    title: Label.weight.uppercased(),
                    buttonLabel: self.appState.reminderWeightDate.timeString,
                    onClick: {
                        self.selectedInput = ReminderType.Weight
                        self.isOpen = true
                    },
                    backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                    accentColor: self.appState.uiTheme.inputAccentColor
                )
            }

            if !self.isOpen || self.selectedInput == ReminderType.Food {
                
                InputSelectButton(
                    title: Label.food.uppercased(),
                    buttonLabel: self.appState.reminderFoodDate.timeString,
                    onClick: {
                        self.selectedInput = ReminderType.Food
                        self.isOpen = true
                    },
                    backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                    accentColor: self.appState.uiTheme.inputAccentColor
                )
            }

            if self.isOpen {
                DatePicker(
                    "",
                    selection: self.getDateInputValue(type: self.selectedInput),
                    displayedComponents: .hourAndMinute
                )
                    .labelsHidden()
                    .font(self.sizes.datePickerFont)
                    .frame(maxWidth: .infinity)
                    .background(self.appState.uiTheme.inputBackgroundColor)
                    .clipped()
                    .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
                    .padding(self.sizes.datePickerPadding)
                
                Button(Label.confirm, action: doneAction)
                    .buttonStyle(AppDefaultButtonStyle(
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                        textColor: self.appState.uiTheme.secondaryTextColor
                    ))
            }
        }
    }
}

struct SetupRemindersBlock_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        SetupRemindersBlock(isOpen: .constant(true))
            .padding(.vertical, 8)
            .background(UIThemeManager.DEFAULT.backgroundColor)
            .environmentObject(appState)
    }
}
