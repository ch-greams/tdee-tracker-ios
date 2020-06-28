//
//  SetupRemindersBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct SetupRemindersBlock: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var selectedInput = ReminderType.WeightInput
    
    @Binding var isOpen: Bool
    

    func getInputBlock(title: String, value: Date, inputType: ReminderType) -> some View {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // or H:mm for 24h
        let stringDate = formatter.string(from: value)
        
        let onInputSelect = {
            self.selectedInput = inputType
            self.isOpen = true
        }
        
        let inputBlock = HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(.appTrendsItemLabel)
                .frame(width: 128, alignment: .leading)
                .padding(.horizontal, 16)
                .foregroundColor(.appPrimary)
            
            Button(stringDate, action: onInputSelect)
                .buttonStyle(ReminderTimeButtonStyle())
                .padding(.trailing, 8)

        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .frame(height: 74)
            .background(Color.white)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .appFade, radius: 1, x: 1, y: 1)
        
        return inputBlock
        
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {

            SetupBlockTitle(title: "Reminders")
            
            if !self.isOpen || self.selectedInput == ReminderType.WeightInput {
                
                self.getInputBlock(
                    title: "Weight",
                    value: self.appState.reminderWeightTime,
                    inputType: ReminderType.WeightInput
                )
            }

            if !self.isOpen || self.selectedInput == ReminderType.FoodInput {

                self.getInputBlock(
                    title: "Food",
                    value: self.appState.reminderFoodTime,
                    inputType: ReminderType.FoodInput
                )
            }

            if self.isOpen {
                DatePicker(
                    "",
                    selection: (
                        self.selectedInput == ReminderType.WeightInput
                            ? self.$appState.reminderWeightTime
                            : self.$appState.reminderFoodTime
                    ),
                    displayedComponents: .hourAndMinute
                )
                    .labelsHidden()
                    .font(.appTrendsItemValue)
                    .foregroundColor(.white)
            }
        }
    }
}

struct SetupRemindersBlock_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        SetupRemindersBlock(isOpen: .constant(true))
            .padding(.vertical, 8)
            .background(Color.appPrimary)
            .environmentObject(appState)
    }
}
