//
//  TutorialOverlay.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 8/18/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


enum TutorialStep: Int {
    
    case Done = 0
    case First = 1
    case Second = 2
    case Third = 3
    case Fourth = 4
    
    var next: TutorialStep {
        
        let nextStepValue = self.rawValue + 1
        
        return (
            nextStepValue > TutorialStep.Fourth.rawValue
                ? TutorialStep.Done
                : TutorialStep(rawValue: nextStepValue) ?? TutorialStep.Done
        )
    }
    
    var label: String {
        switch self {
            case TutorialStep.First:
                return Label.tutorialFirstStep
            case TutorialStep.Second:
                return Label.tutorialSecondStep
            case TutorialStep.Third:
                return Label.tutorialThirdStep
            case TutorialStep.Fourth:
                return Label.tutorialFourthStep
            case TutorialStep.Done:
                return ""
        }
    }
    
    func isDoneOrEqual(_ step: TutorialStep = TutorialStep.Done) -> Bool {
        return self == .Done || self == step
    }
}

struct TutorialOverlaySizes {

    // MARK: - Sizes
    
    public let messageLineSpacing: CGFloat = 6
    
    public let messageMinHeight: CGFloat = 58
    public let messagePadding: CGFloat = 16
    public let messageHPadding: CGFloat = 8
    
    // MARK: - Fonts

    public let labelFont: Font = .custom(FontOswald.Light, size: 17)
}


struct TutorialOverlay: View {
    
    private let sizes = TutorialOverlaySizes()
    
    let mainColor: Color
    let accentColor: Color
    
    let step: TutorialStep
    
    let nextStepAction: () -> Void


    var body: some View {
        
        ZStack(alignment: .top) {
           
            VStack(alignment: .center, spacing: 0) {
                
                Text(self.step.label)
                    .foregroundColor(self.mainColor)
                    .font(self.sizes.labelFont)
                    .lineSpacing(self.sizes.messageLineSpacing)
                    .multilineTextAlignment(.center)
            }
                .frame(maxWidth: .infinity)
                .frame(minHeight: self.sizes.messageMinHeight)
                .padding(self.sizes.messagePadding)
                .background(self.accentColor)
                .onTapGesture(perform: self.nextStepAction)
                .clipped()
                .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
                .padding(.horizontal, self.sizes.messageHPadding)
        }
    }
}

struct TutorialOverlay_Previews: PreviewProvider {
    static var previews: some View {
        TutorialOverlay(
            mainColor: UIThemeManager.DEFAULT.backgroundColor,
            accentColor: UIThemeManager.DEFAULT.mainTextColor,
            step: TutorialStep.Fourth,
            nextStepAction: { print("next step") }
        )
    }
}
