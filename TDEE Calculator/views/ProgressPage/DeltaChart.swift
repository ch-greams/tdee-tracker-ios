//
//  DeltaChart.swift
//  TDEE Calculator
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
    
    
    let dash: [ CGFloat ] = [ 4 ]
    
    let stepZeroHeight: CGFloat = 20
    
    let totalStepsHeight: CGFloat = 180
    
    let entries: [ Int : Double ] = [
      1 : 0.085,
      2 : 0.878,
      3 : 0.03,
      4 : 0.084,
      5 : 0.524,
      6 : 0.098,
      7 : 0.235,
      8 : 0.778,
      9 : 0.23,
      10 : 0.525,
      11 : 0.24,
      12 : 0.966
    ]
    
    // let entries: [ Int : Double ] = [ 1 : 0.15 ]
    
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
        
        for step in 1...stepCount {
            // NOTE: Use Decimal so you won't get numbers like 0.600...01 instead of 0.6
            result.append("\( Decimal(step) * Decimal(stepValue) ) KG")
        }
        
        return result.reversed()
    }

    // MARK: - Chart Background
    
    func getLineBlock(mark: String, length: Int, height: CGFloat, withDash: Bool = true) -> some View {
        
        VStack(alignment: .leading, spacing: 0) {
        
            Text(mark)
                .frame(width: 40, alignment: .trailing)
                .font(.appProgressChartSegment)
                .padding(.leading, 8)
                .foregroundColor(Color.white)
            
            Line(length: length)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: ( withDash ? self.dash : [] )))
                .frame(height: 1)
                .foregroundColor(Color.white)
        }
            .frame(height: height, alignment: .top)
    }

    func getChartBackground(steps: [ String ], stepHeight: CGFloat, width: Int) -> some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            ForEach(steps, id: \.self) { step in
                
                self.getLineBlock(mark: step, length: width, height: stepHeight)
            }
            
            self.getLineBlock(mark: "0 KG", length: width, height: self.stepZeroHeight, withDash: false)
        }
    }

    // MARK: - Body
    
    var body: some View {
        
        let maxEntryValue = self.entries.values.max { $0 < $1 } ?? 0.0
        let stepValue = self.getStepValue(value: maxEntryValue)
        let stepCount = Int( ( maxEntryValue / stepValue ).rounded(.up) )
        
        let steps = self.getSteps(stepValue: stepValue, stepCount: stepCount)
        let stepHeight = self.getStepHeight(stepCount: stepCount)
        
        // NOTE: Have to calculate height otherwise GeometryReader will take everything it can
        let blockHeight = self.totalStepsHeight + self.stepZeroHeight

        var entryHeights: [ CGFloat ] = []
        
        for index in 1...self.entries.count {
            
            var entryHeight: CGFloat = 0
            
            if let entryValue = self.entries[index] {
                
                entryHeight = CGFloat( entryValue / stepValue ) * stepHeight
            }
            
            entryHeights.append(entryHeight)
        }
        
        
        let block = ZStack(alignment: .topLeading) {
            
            GeometryReader { geometry in
            
                self.getChartBackground(steps: steps, stepHeight: stepHeight, width: Int(geometry.size.width))
                
                HStack(alignment: .top, spacing: 0) {
                        
                    ForEach(0 ..< entryHeights.count) { iWeek in
                        
                        VStack(alignment: .center, spacing: 0) {
                            Rectangle()
                                .padding(.top, self.totalStepsHeight - entryHeights[iWeek])
                                .frame(width: 20, height: self.totalStepsHeight)
                                .padding(.top, 11)
                                .padding(.horizontal, 1)
                                .foregroundColor(Color.white)
                            
                            // TODO: Replace with keys
                            Text(String(iWeek + 1))
                                .font(.appProgressChartSegment)
                                .padding(.top, 4)
                                .foregroundColor(Color.white)
                        }
                    }
                }
                    .padding(.leading, 60)
            }
                .frame(maxHeight: blockHeight)
                
        }
        
        return block.padding(.vertical, 10)
    }
}

struct DeltaChart_Previews: PreviewProvider {
    static var previews: some View {
        DeltaChart().background(Color.appPrimary)
    }
}
