//
//  ProgressCircle.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/21/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct ProgressCircle: View {
    
    let currentValue: Double
    let goalValue: Double
    let unit: String
    
    let estimatedTimeLeft: Int

    var body: some View {
        
        let width: CGFloat = 40
        let diameter: CGFloat = 340
        
        let absCurrentValue = abs(self.currentValue)
        let absGoalValue = abs(self.goalValue)
        let absEstimatedTimeLeft = abs(self.estimatedTimeLeft)
        
        let progress = absCurrentValue / absGoalValue
        
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
                
                Text(String(format: "%.1f%%", progress * 100))
                    .font(.appProgressCirclePercent)
                    .foregroundColor(.white)

                Text(String(format: "%.1f / %.1f \(unit)", absCurrentValue, absGoalValue))
                    .font(.appProgressCircleValues)
                    .foregroundColor(.white)

                Text("~ \(absEstimatedTimeLeft) weeks")
                    .font(.appProgressCircleEstimate)
                    .foregroundColor(.white)
            }
            
        }.frame(height: diameter)

    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        
        ProgressCircle(currentValue: 3.3, goalValue: 5.1, unit: "kg", estimatedTimeLeft: 7)
            .padding(.vertical, 20)
            .background(Color.appPrimary)
    }
}
