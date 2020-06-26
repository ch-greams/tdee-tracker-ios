//
//  UIApplication.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/5/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
