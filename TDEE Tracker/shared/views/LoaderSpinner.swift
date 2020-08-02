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
    
    var text: String = "Loading store"
    
    var diameter: CGFloat = 50
    
    @State var rotationAngle: Angle = .degrees(0)
    
    var spinner: some View {
        
        ZStack(alignment: .center) {

            Circle()
                .stroke(self.accentColor, lineWidth: 10)
                .frame(height: self.diameter)
            
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(self.mainColor, lineWidth: 8)
                .rotationEffect(self.rotationAngle)
                .frame(height: self.diameter)
                .onAppear() {
                    withAnimation(
                        Animation
                            .linear(duration: 1.4)
                            .repeatForever(autoreverses: false)
                    ) {
                        self.rotationAngle = .degrees(360)
                    }
                }
                .onDisappear() { self.rotationAngle = .degrees(0) }
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {

            self.mainColor
                .opacity(0.75)
                .edgesIgnoringSafeArea(.all)
           
            VStack(alignment: .center, spacing: 24) {
                
                self.spinner
                
                if !self.text.isEmpty {
                    
                    Text(self.text.uppercased())
                        .foregroundColor(self.accentColor)
                        .font(Font.customFont(font: FontOswald.Regular, size: 22))
                }
            }
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
