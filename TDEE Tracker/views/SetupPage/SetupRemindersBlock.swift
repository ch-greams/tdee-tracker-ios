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
    
    @State var isWeightOpen: Bool = false
    @State var isFoodOpen: Bool = false

    
    var body: some View {
        
        return VStack(alignment: .center, spacing: 0) {

            SetupBlockTitle(
                title: Label.reminders,
                textColor: self.appState.uiTheme.mainTextColor
            )
            
            InputTime(
                title: Label.weight.uppercased(),
                inputValue: self.appState.reminderWeightDateInput,
                onCommit: {
                    self.appState.saveWeightReminderDateFromInput()
                    
                    self.appState.currentInput = nil
                    self.isWeightOpen = false
                },
                openInput: {
                    self.appState.currentInput = InputName.ReminderWeightDate
                    self.isWeightOpen = true
                },
                isOpen: self.isWeightOpen,
                isSelected: self.appState.currentInput == InputName.ReminderWeightDate,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                backgroundSelectedColor: self.appState.uiTheme.calendarWeekHighlight,
                confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
                accentColor: self.appState.uiTheme.inputAccentColor
            )
            
            InputTime(
                title: Label.food.uppercased(),
                inputValue: self.appState.reminderFoodDateInput,
                onCommit: {
                    self.appState.saveFoodReminderDateFromInput()
                    
                    self.appState.currentInput = nil
                    self.isFoodOpen = false
                },
                openInput: {
                    self.appState.currentInput = InputName.ReminderFoodDate
                    self.isFoodOpen = true
                },
                isOpen: self.isFoodOpen,
                isSelected: self.appState.currentInput == InputName.ReminderFoodDate,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                backgroundSelectedColor: self.appState.uiTheme.calendarWeekHighlight,
                confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
                accentColor: self.appState.uiTheme.inputAccentColor
            )
        }
    }
}

struct SetupRemindersBlock_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        SetupRemindersBlock()
            .padding(.vertical, 8)
            .background(UIThemeManager.DEFAULT.backgroundColor)
            .environmentObject(appState)
    }
}
