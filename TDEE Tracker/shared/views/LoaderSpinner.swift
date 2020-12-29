//
//  LoaderSpinner.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/29/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct LoaderSpinnerSizes {
    
    // MARK: - Sizes
    
    public let circleSize: CGFloat
    
    public let circleBackLineWidth: CGFloat
    public let circleFrontLineWidth: CGFloat
    
    public let spinnerBPadding: CGFloat
    
    // MARK: - Fonts

    public let loaderFont: Font

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {

        self.circleSize = scale * 50
        
        self.circleBackLineWidth = scale * 10
        self.circleFrontLineWidth = scale * 8
        
        self.spinnerBPadding = scale * 24

        self.loaderFont = .custom(FontOswald.Regular, size: scale * 22)
    }
}


struct LoaderSpinner: View {
    
    private let sizes = LoaderSpinnerSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    let mainColor: Color
    let accentColor: Color
    
    let text: String
    
    @State var rotationAngle: Angle = .degrees(0)
    
    var spinner: some View {
        
        ZStack(alignment: .center) {

            Circle()
                .stroke(self.accentColor, lineWidth: self.sizes.circleBackLineWidth)
                .frame(height: self.sizes.circleSize)
            
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(self.mainColor, lineWidth: self.sizes.circleFrontLineWidth)
                .rotationEffect(self.rotationAngle)
                .frame(height: self.sizes.circleSize)
                .onAppear {
                    withAnimation(
                        Animation
                            .linear(duration: 1.4)
                            .repeatForever(autoreverses: false)
                    ) {
                        self.rotationAngle = .degrees(360)
                    }
                }
                .onDisappear { self.rotationAngle = .degrees(0) }
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {

            self.mainColor
                .opacity(0.75)
                .edgesIgnoringSafeArea(.all)
           
            VStack(alignment: .center, spacing: 0) {
                
                self.spinner
                    .padding(.bottom, self.sizes.spinnerBPadding)
                
                Text(self.text.uppercased())
                    .foregroundColor(self.accentColor)
                    .font(self.sizes.loaderFont)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct LoaderSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoaderSpinner(
            mainColor: UIThemeManager.DEFAULT.backgroundColor,
            accentColor: UIThemeManager.DEFAULT.mainTextColor,
            text: Label.fetchProducts
        )
    }
}
