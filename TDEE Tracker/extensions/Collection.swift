//
//  Collection.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/9/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation


extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    public func get(_ index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Collection where Element: BinaryInteger {

    /// Returns the average of all elements in the array
    public func average() -> Element { isEmpty ? .zero : sum() / Element(count) }

    /// Returns the average of all elements in the array as Floating Point type
    public func average<T: FloatingPoint>() -> T { isEmpty ? .zero : T(sum()) / T(count) }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    public func average() -> Element { isEmpty ? .zero : Element(sum()) / Element(count) }
}
