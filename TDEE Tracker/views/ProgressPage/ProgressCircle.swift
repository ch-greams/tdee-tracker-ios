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

    var body: some View {
        
        let absCurrentWeightValue = self.currentWeightValue
        let absGoalWeightValue = self.goalWeightValue
        let absEstimatedTimeLeft = self.estimatedTimeLeft
        
        let progress = absCurrentWeightValue / absGoalWeightValue
        
        return ZStack {
            
            Circle()
                .stroke(Color.appWhite, lineWidth: self.circleWidth)
                .opacity(0.2)
                .frame(height: self.circleDiameter - self.circleWidth)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(Color.appWhite, lineWidth: self.circleWidth)
                .rotationEffect(.degrees(-90))
                .frame(height: self.circleDiameter - self.circleWidth)
                
            
            VStack {
                
                if progress > 1 {
                    
                    Text("DONE!")
                        .font(.appProgressCirclePercent)
                        .foregroundColor(.appWhite)
                }
                else {
                    Text(String(format: "%.1f%%", progress * 100))
                        .font(.appProgressCirclePercent)
                        .foregroundColor(.appWhite)

                    Text(String(format: "%.1f / %.1f \(unit)", absCurrentWeightValue, absGoalWeightValue))
                        .font(.appProgressCircleValues)
                        .foregroundColor(.appWhite)

                    Text("~ \(absEstimatedTimeLeft) weeks")
                        .font(.appProgressCircleEstimate)
                        .foregroundColor(.appWhite)
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
            unit: "kg",
            estimatedTimeLeft: 7
        )
            .padding(.vertical, 20)
            .background(Color.appPrimary)
    }
}
