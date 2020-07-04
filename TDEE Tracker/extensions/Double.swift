//
//  Double.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/22/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation

extension Double {

    func rounded(to places:Int) -> Double {

        let divisor = pow(10, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
