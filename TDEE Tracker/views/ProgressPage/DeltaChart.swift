//
//  DeltaChart.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/18/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct Line: Shape {

    var length: Int
    
    func path(in rect: CGRect) -> Path {

        var path = Path()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.length, y: 0))

        return path
    }
}



struct DeltaChart: View {

    let totalStepsHeight: CGFloat
    
    let STEP_LINE_DASH: [ CGFloat ] = [ 4 ]
    let STEP_ZERO_HEIGHT: CGFloat = 20
    
    let MIN_MAX_DELTA_VALUE: Double = 0.2
    
    let weeklyDeltas: [ Double ]
    
    let weightUnit: String
    
    let mainColor: Color
    
    @State var visibleMultiplier: CGFloat = 0
    
    // MARK: - Size Calculation
    
    func getStepHeight(stepCount: Int) -> CGFloat {
        
        return self.totalStepsHeight / CGFloat(stepCount)
    }

    func getStepValue(value: Double) -> Double {

        switch value {

            case _ where value >= 0 && value <= 0.2:
                return 0.05 // NOTE: 1 - 4 steps
            case _ where value > 0.2 && value <= 0.4:
                return 0.1  // NOTE: 3 - 4 steps
            case _ where value > 0.4 && value <= 1:
                return 0.2  // NOTE: 3 - 5 steps
            case _ where value > 1 && value <= 3:
                return 0.5  // NOTE: 3 - 6 steps
            default:
                return 1
        }
    }

    func getSteps(stepValue: Double, stepCount: Int) -> [ String ] {
        
        var result: [ String ] = []
        
        if stepCount > 0 {
            for step in 1...stepCount {
                // NOTE: Use Decimal so you won't get numbers like 0.600...01 instead of 0.6
                result.append("\( Decimal(step) * Decimal(stepValue) ) \(self.weightUnit)")
            }
        }
        
        return result.reversed()
    }

    // MARK: - Chart Background
    
    func getMaxWeeklyDeltaValue(weeklyDeltas: [ Double ], maxValue: Double) -> Double {

        return weeklyDeltas
            .max { $0 < $1 }
            .map { ( $0 < maxValue ) ? maxValue : $0 } ?? maxValue
    }
    
    func getLineBlock(mark: String, length: Int, height: CGFloat, withDash: Bool = true) -> some View {
        
        VStack(alignment: .leading, spacing: 0) {
        
            Text(mark)
                .frame(width: 40, alignment: .trailing)
                .font(.appProgressChartSegment)
                .padding(.leading, 8)
                .foregroundColor(self.mainColor)
            
            Line(length: length)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: ( withDash ? self.STEP_LINE_DASH : [] )))
                .frame(height: 1)
                .foregroundColor(self.mainColor)
        }
            .frame(height: height, alignment: .top)
    }

    func getChartBackground(steps: [ String ], stepHeight: CGFloat, width: Int) -> some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            ForEach(steps, id: \.self) { step in
                
                self.getLineBlock(mark: step, length: width, height: stepHeight)
            }
            
            self.getLineBlock(
                mark: "0 \(self.weightUnit)",
                length: width,
                height: self.STEP_ZERO_HEIGHT,
                withDash: false
            )
        }
    }

    // MARK: - Body
    
    var body: some View {
        
        let absWeeklyDeltas = self.weeklyDeltas.map { abs($0) }
        
        let maxWeeklyDeltaValue = self.getMaxWeeklyDeltaValue(
            weeklyDeltas: absWeeklyDeltas,
            maxValue: self.MIN_MAX_DELTA_VALUE
        )

        let stepValue = self.getStepValue(value: maxWeeklyDeltaValue)
        let stepCount = Int( ( maxWeeklyDeltaValue / stepValue ).rounded(.up) )
        
        let steps = self.getSteps(stepValue: stepValue, stepCount: stepCount)
        let stepHeight = self.getStepHeight(stepCount: stepCount)
        
        // NOTE: Have to calculate height otherwise GeometryReader will take everything it can
        let totalChartHeight = self.totalStepsHeight + self.STEP_ZERO_HEIGHT

        var weeklyDeltaHeights: [ CGFloat ] = []
        
        for weeklyDeltaValue in absWeeklyDeltas {
            
            weeklyDeltaHeights.append( CGFloat( weeklyDeltaValue / stepValue ) * stepHeight )
        }
        
        
        let block = ZStack(alignment: .topLeading) {
            
            GeometryReader { geometry in
            
                self.getChartBackground(steps: steps, stepHeight: stepHeight, width: Int(geometry.size.width))
                
                // NOTE: Top HStack is necessary for mask
                HStack {

                    ScrollView(.horizontal, showsIndicators: false) {
                    
                        HStack(alignment: .top, spacing: 0) {

                            ForEach(0 ..< weeklyDeltaHeights.count) { iWeek in
                                
                                VStack(alignment: .center, spacing: 0) {
                                    Rectangle()
                                        .padding(
                                            .top,
                                            self.totalStepsHeight - weeklyDeltaHeights[iWeek] * self.visibleMultiplier
                                        )
                                        .frame(width: 28, height: self.totalStepsHeight)
                                        .padding(.top, 15)
                                        .padding(.horizontal, 1)
                                        .foregroundColor(self.mainColor)
                                        .opacity(0.85)
                                        .onAppear {
                                            withAnimation( Animation.linear(duration: 0.4) ) {
                                                 self.visibleMultiplier = 1
                                            }
                                        }

                                    Text(String(iWeek + 1))
                                        .font(.appProgressChartSegment)
                                        .padding(.top, 1)
                                        .foregroundColor(self.mainColor)
                                }
                            }
                        }
                    }
                }
                    .padding(.leading, 60)
            }
                .frame(maxHeight: totalChartHeight)
                
        }
        
        return block.padding(.vertical, 10)
    }
}

struct DeltaChart_Previews: PreviewProvider {
    
    static let weeklyDeltas: [ Double ] = [
        0.085, 1, 0.03, 0.084, 0.6, 0.098, 0.235, 0.778, 0.23, 0.525, 0.24, 0.966,
        0.085, 0.878, 0.03, 0.084, 0.524, 0.098, 0.235, 0.778, 0.23, 0.525, 0.24, 0.966
    ]
    
    static var previews: some View {
        
        VStack {

            // NOTE: With data
            DeltaChart(
                totalStepsHeight: 180,
                weeklyDeltas: Self.weeklyDeltas,
                weightUnit: WeightUnit.kg.localized,
                mainColor: UIThemeManager.DEFAULT.mainTextColor
            )
                .background(UIThemeManager.DEFAULT.backgroundColor)
            
            // NOTE: Empty
            DeltaChart(
                totalStepsHeight: 180,
                weeklyDeltas: [],
                weightUnit: WeightUnit.kg.localized,
                mainColor: UIThemeManager.DEFAULT.mainTextColor
            )
                .background(UIThemeManager.DEFAULT.backgroundColor)
        }
    }
}
