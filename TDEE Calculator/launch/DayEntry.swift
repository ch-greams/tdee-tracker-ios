//
//  DayEntry.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation

class DayEntry: NSObject, NSCoding {

    //var date: Date
    var weight: Int?    // TODO: Change to Double
    var food: Int?
    
    init(weight: Int?, food: Int?) {
        self.weight = weight
        self.food = food
    }
    
    required init(coder aDecoder: NSCoder) {
        self.weight = aDecoder.decodeObject(forKey: "weight") as? Int
        self.food = aDecoder.decodeObject(forKey: "food") as? Int
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(food, forKey: "food")
    }

}

