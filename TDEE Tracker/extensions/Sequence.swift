//
//  Sequence.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/9/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation

extension Sequence where Element: AdditiveArithmetic {

    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}
