//
//  SetupPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/9/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct SetupPageSizes {
    
    // MARK: - Sizes
    
    public let separatorHeight: CGFloat
    public let separatorHPadding: CGFloat
    
    public let navbarViewHeight: CGFloat
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.separatorHeight = 1
        self.separatorHPadding = 32

        if hasNotch {
            self.navbarViewHeight = scale * 84
        }
        else {
            self.navbarViewHeight = scale * 56
        }
    }
}


struct SetupPage: View {
    
    private let sizes = SetupPageSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)

    @EnvironmentObject var appState: AppState

    @State private var isReminderOpen: Bool = false

    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 0) {
                    
                SetupUnitsBlock()

                SetupGoalBlock()

                Rectangle()
                    .frame(height: self.sizes.separatorHeight)
                    .padding(.horizontal, self.sizes.separatorHPadding)
                    .foregroundColor(self.appState.uiTheme.mainTextColor)
                    .opacity(0.8)
                
                SetupHealthBlock()

                SetupRemindersBlock()
                
                SetupThemeBlock()
            }
                .padding(.bottom, self.sizes.navbarViewHeight)
        }
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
