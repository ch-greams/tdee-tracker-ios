//
//  DayEntry.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation

enum DayEntryData {

    case Empty, Partial, Full
}

class DayEntry: NSObject, NSCoding {

    var weight: Double?
    var food: Int?
    
    init(weight: Double?, food: Int?) {
        self.weight = weight
        self.food = food
    }
    
    required init(coder aDecoder: NSCoder) {
        self.weight = aDecoder.decodeObject(forKey: "weight") as? Double
        self.food = aDecoder.decodeObject(forKey: "food") as? Int
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(food, forKey: "food")
    }
}
