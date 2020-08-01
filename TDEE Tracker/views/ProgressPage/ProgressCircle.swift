//
//  ProgressCircle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/21/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct ProgressCircle: View {
    
    let circleDiameter: CGFloat
    let circleWidth: CGFloat
    
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
                .stroke(self.mainColor, lineWidth: self.circleWidth)
                .opacity(0.2)
                .frame(height: self.circleDiameter - self.circleWidth)
            
            Circle()
                .trim(from: 0, to: self.visibleProgress)
                .stroke(self.mainColor, lineWidth: self.circleWidth)
                .rotationEffect(.degrees(-90))
                .frame(height: self.circleDiameter - self.circleWidth)
                .onAppear {
                    withAnimation( Animation.linear(duration: 0.5) ) {
                        self.visibleProgress = CGFloat(progress)
                    }
                }
                
            
            VStack {
                
                if progress >= 1 {
                    
                    Text("\(Label.done)!")
                        .font(.appProgressCirclePercent)
                        .foregroundColor(self.mainColor)
                }
                else {

                    Text(progressPercentText)
                        .font(.appProgressCirclePercent)
                        .foregroundColor(self.mainColor)

                    Text(progressValueText)
                        .font(.appProgressCircleValues)
                        .foregroundColor(self.mainColor)

                    Text(estimatedTimeLeftText)
                        .font(.appProgressCircleEstimate)
                        .foregroundColor(self.mainColor)
                }
            }
            
        }
            .frame(height: self.circleDiameter)

    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        
        ProgressCircle(
            circleDiameter: 340,
            circleWidth: 40,
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
