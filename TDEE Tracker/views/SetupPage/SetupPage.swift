//
//  SetupPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/9/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct SetupPageStyle {
    
    // MARK: - Sizes
    
    public let separatorHeight: CGFloat = 1
    public let separatorHPadding: CGFloat = 32
    
    public let reminderOpenTPadding: CGFloat = 60
    
    public let mvVisibleScreenHeight: CGFloat
    public let mvVisibleScreenOffset: CGFloat
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.mvVisibleScreenHeight = uiSizes.mvVisibleScreenHeight
        self.mvVisibleScreenOffset = uiSizes.mvVisibleScreenOffset
    }
}


struct SetupPage: View {
    
    private let style: SetupPageStyle = SetupPageStyle(uiSizes: UISizes.current)

    @EnvironmentObject var appState: AppState

    @State private var isReminderOpen: Bool = false

    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 0) {

                if !self.isReminderOpen {
                    
                    SetupUnitsBlock()

                    SetupGoalBlock()

                    Rectangle()
                        .frame(height: self.style.separatorHeight)
                        .padding(.horizontal, self.style.separatorHPadding)
                        .foregroundColor(self.appState.uiTheme.mainTextColor)
                        .opacity(0.8)
                }

                SetupRemindersBlock(isOpen: self.$isReminderOpen)
                    .padding(.top, self.isReminderOpen ? self.style.reminderOpenTPadding : 0)
                
                if !self.isReminderOpen {
                 
                    SetupThemeBlock()
                }
            }
        }
            .frame(height: self.style.mvVisibleScreenHeight - self.style.mvVisibleScreenOffset)
    }
}

struct SetupPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        
        ZStack(alignment: .top) {
            
            Self.appState.uiTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            SetupPage().environmentObject(appState)
        }
    }
}
