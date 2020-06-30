//
//  ProgressCircle.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/21/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct ProgressCircle: View {
    
    let currentWeightValue: Double
    let goalWeightValue: Double
    let unit: String
    
    let estimatedTimeLeft: Int

    var body: some View {
        
        let width: CGFloat = 40
        let diameter: CGFloat = 340
        
        let absCurrentWeightValue = self.currentWeightValue
        let absGoalWeightValue = self.goalWeightValue
        let absEstimatedTimeLeft = self.estimatedTimeLeft
        
        let progress = absCurrentWeightValue / absGoalWeightValue
        
        return ZStack {
            
            Circle()
                .stroke(Color.white, lineWidth: width)
                .opacity(0.2)
                .frame(height: diameter - width)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(Color.white, lineWidth: width)
                .rotationEffect(.degrees(-90))
                .frame(height: diameter - width)
                
            
            VStack {
                
                if progress > 1 {
                    
                    Text("DONE!")
                        .font(.appProgressCirclePercent)
                        .foregroundColor(.white)
                }
                else {
                    Text(String(format: "%.1f%%", progress * 100))
                        .font(.appProgressCirclePercent)
                        .foregroundColor(.white)

                    Text(String(format: "%.1f / %.1f \(unit)", absCurrentWeightValue, absGoalWeightValue))
                        .font(.appProgressCircleValues)
                        .foregroundColor(.white)

                    Text("~ \(absEstimatedTimeLeft) weeks")
                        .font(.appProgressCircleEstimate)
                        .foregroundColor(.white)
                }
            }
            
        }.frame(height: diameter)

    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        
        ProgressCircle(currentWeightValue: 3.3, goalWeightValue: 5.1, unit: "kg", estimatedTimeLeft: 7)
            .padding(.vertical, 20)
            .background(Color.appPrimary)
    }
}
