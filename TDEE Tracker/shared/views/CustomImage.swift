//
//  CustomImage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct CustomImage: UIViewRepresentable {

    var name: String
    var contentMode: UIView.ContentMode = .scaleAspectFit
    var colorName: String = ""

    func makeUIView(context: Context) -> UIImageView {

        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {

        uiView.contentMode = self.contentMode
        uiView.tintColor = UIColor(named: self.colorName) ?? UIColor.white

        if let image = UIImage(named: self.name) {
            uiView.image = image
        }
    }
}
