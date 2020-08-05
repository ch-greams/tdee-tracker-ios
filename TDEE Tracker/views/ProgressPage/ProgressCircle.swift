//
//  ProgressCircle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/21/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct ProgressCircleStyle {
    
    // MARK: - Sizes
    
    public let circleDiameter: CGFloat
    public let circleWidth: CGFloat
    
    // MARK: - Fonts
    
    public let percentFont: Font = .custom(FontOswald.Light, size: 64)
    public let valuesFont: Font = .custom(FontOswald.Medium, size: 32)
    public let estimateFont: Font = .custom(FontOswald.Light, size: 28)
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.circleDiameter = uiSizes.progressCircleDiameter
        self.circleWidth = uiSizes.progressCircleWidth
    }
}


    
struct ProgressCircle: View {
    
    private let style: ProgressCircleStyle = ProgressCircleStyle(uiSizes: UISizes.current)
    
    let currentWeightValue: Double
    let goalWeightValue: Double
    let unit: String
    
    let estimatedTimeLeft: Int
    
    let mainColor: Color
    
    @State var visibleProgress: CGFloat = 0

    func getWeekLabel(amount: Int) -> String {
    
        switch amount {
            case _ where amount == 1:
                return Label.week
            case _ where amount >= 2 && amount <= 4:
                return Label.coupleWeeks
            default:
                return Label.manyWeeks
        }
    }

    var body: some View {
        
        let progress = self.currentWeightValue / self.goalWeightValue
        let progressPercentText = "\( ( progress * 100 ).toString(to: 1) )%"
        
        let currentWeightText = self.currentWeightValue.toString(to: 1)
        let goalWeightText = self.goalWeightValue.toString(to: 1)
        let progressValueText = "\(currentWeightText) / \(goalWeightText) \(unit)"
        
        let weekLabel = self.getWeekLabel(amount: self.estimatedTimeLeft)
        let estimatedTimeLeftText = "~ \(self.estimatedTimeLeft) \(weekLabel)"
        
        return ZStack {
            
            Circle()
                .stroke(self.mainColor, lineWidth: self.style.circleWidth)
                .opacity(0.2)
                .frame(height: self.style.circleDiameter - self.style.circleWidth)
            
            Circle()
                .trim(from: 0, to: self.visibleProgress)
                .stroke(self.mainColor, lineWidth: self.style.circleWidth)
                .rotationEffect(.degrees(-90))
                .frame(height: self.style.circleDiameter - self.style.circleWidth)
                .onAppear {
                    withAnimation( Animation.linear(duration: 0.5) ) {
                        self.visibleProgress = CGFloat(progress)
                    }
                }
            
            VStack {
                
                if progress >= 1 {
                    
                    Text("\(Label.done)!")
                        .font(self.style.percentFont)
                        .foregroundColor(self.mainColor)
                }
                else {

                    Text(progressPercentText)
                        .font(self.style.percentFont)
                        .foregroundColor(self.mainColor)

                    Text(progressValueText)
                        .font(self.style.valuesFont)
                        .foregroundColor(self.mainColor)

                    Text(estimatedTimeLeftText)
                        .font(self.style.estimateFont)
                        .foregroundColor(self.mainColor)
                }
            }
            
        }
            .frame(height: self.style.circleDiameter)
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        
        ProgressCircle(
            currentWeightValue: 3.3,
            goalWeightValue: 5.1,
            unit: WeightUnit.kg.localized,
            estimatedTimeLeft: 7,
            mainColor: UIThemeManager.DEFAULT.mainTextColor
        )
            .padding(.vertical, 20)
            .background(UIThemeManager.DEFAULT.backgroundColor)
    }
}
