//
//  EntryPage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct CustomButtonBackgroundStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 44.0, height: 10.0)
            .padding()
            .foregroundColor(.appPrimary)
            .background(Color(hue: 0, saturation: 0, brightness: 0.96))
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .gray, radius: 1, x: 1, y: 1)
            
    }
}

struct EntryPage: View {

    
    func getMonth() -> Text {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        
        let monthString = dateFormatter.string(from: Date())
        
        return Text(monthString.uppercased())
            .font(.appCalendarMonth)
            .foregroundColor(.white)
    }
    
    func getButton(type: String) -> some View {

        Button(action: { print("test") }) {
            Image(systemName: "arrow.\(type)")
                .font(.headline)
        }
        .buttonStyle(CustomButtonBackgroundStyle())
    }
    
    
    
    var body: some View {

        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
                
                HStack(alignment: .center) {

                    self.getButton(type: "left")
                    
                    self.getMonth()
                        .frame(width: 174.0)
                    
                    self.getButton(type: "right")
                }
                
                CalendarBlock()
                
                RecommendedAmountBlock()
                
                EntryInputBlock()

            }
        }
        

    }
}

struct EntryPage_Previews: PreviewProvider {
    static var previews: some View {
        EntryPage()
    }
}
