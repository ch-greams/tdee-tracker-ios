//
//  SetupRemindersBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct SetupRemindersBlock: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var selectedInput = ReminderType.Weight
    
    @Binding var isOpen: Bool
    

    
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
                    height: self.appState.uiSizes.setupInputHeight,
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
                    height: self.appState.uiSizes.setupInputHeight,
                    backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                    accentColor: self.appState.uiTheme.inputAccentColor
                )
            }

            if self.isOpen {
                DatePicker(
                    "",
                    selection: (
                        self.selectedInput == ReminderType.Weight
                            ? self.$appState.reminderWeightDate
                            : self.$appState.reminderFoodDate
                    ),
                    displayedComponents: .hourAndMinute
                )
                    .labelsHidden()
                    .font(.appInputValue)
                    .frame(maxWidth: .infinity)
                    .background(self.appState.uiTheme.inputBackgroundColor)
                    .clipped()
                    .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
                    .padding(8)
                
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
