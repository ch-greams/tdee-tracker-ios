//
//  ProgressPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/18/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct ProgressPageStyle {
    
    // MARK: - Sizes
    
    public let pageTitleTPadding: CGFloat = 4
    
    public let deltaChartVPadding: CGFloat
    
    // MARK: - Fonts

    public let pageTitleFont: Font = .custom(FontOswald.Medium, size: 24)
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.deltaChartVPadding = uiSizes.progressPageSpacing
    }
}


struct ProgressPage: View {
    
    private let style: ProgressPageStyle = ProgressPageStyle(uiSizes: UISizes.current)
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        let startDate = self.appState.firstEntryDate.toString(Label.progressDateFormat)
        let title = "\(Label.startingFrom) \(startDate)".uppercased()
        
        let progressData = self.appState.progressData
        
        return VStack(alignment: .center, spacing: 0) {
            
            Text(title)
                .font(self.style.pageTitleFont)
                .foregroundColor(self.appState.uiTheme.mainTextColor)
                .padding(.top, self.style.pageTitleTPadding)
            
            DeltaChart(
                weeklyDeltas: self.appState.weeklyWeightDeltas,
                weightUnit: self.appState.weightUnit.localized,
                mainColor: self.appState.uiTheme.mainTextColor
            )
                .padding(.vertical, self.style.deltaChartVPadding)

            ProgressCircle(
                currentWeightValue: progressData.progressWeight,
                goalWeightValue: progressData.goalWeight,
                unit: self.appState.weightUnit.localized,
                estimatedTimeLeft: progressData.estimatedTimeLeft,
                mainColor: self.appState.uiTheme.mainTextColor
            )
        }
    }
}

struct ProgressPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        ZStack(alignment: .top) {
            
            Self.appState.uiTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ProgressPage().environmentObject(appState)
        }
    }
}
