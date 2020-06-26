//
//  Collection.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/9/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation

extension Collection where Element: BinaryInteger {

    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }

    /// Returns the average of all elements in the array as Floating Point type
    func average<T: FloatingPoint>() -> T { isEmpty ? .zero : T(sum()) / T(count) }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : Element(sum()) / Element(count) }
}
