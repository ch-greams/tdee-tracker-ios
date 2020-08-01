//
//  LoaderSpinner.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/29/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct LoaderSpinner: View {
    
    let mainColor: Color
    let accentColor: Color
    
    @State var rotationAngle: Angle = .degrees(360)
    
    var body: some View {
        
        let diameter: CGFloat = 50
        
        return ZStack(alignment: .center) {

            self.mainColor
                .opacity(0.75)
                .edgesIgnoringSafeArea(.all)
           
            Circle()
                .stroke(self.accentColor, lineWidth: 10)
                .frame(height: diameter)
            
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(self.mainColor, lineWidth: 8)
                .rotationEffect(self.rotationAngle)
                .frame(height: diameter)
                .onAppear() {
                    withAnimation(
                        Animation
                            .linear(duration: 1.4)
                            .repeatForever(autoreverses: false)
                    ) {
                        self.rotationAngle = .degrees(0)
                    }
                }
                .onDisappear() { self.rotationAngle = .degrees(360) }
        }
    }
}

struct LoaderSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoaderSpinner(
            mainColor: UIThemeManager.DEFAULT.backgroundColor,
            accentColor: UIThemeManager.DEFAULT.mainTextColor
        )
    }
}
