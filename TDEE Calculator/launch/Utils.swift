//
//  Utils.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/8/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation


class Utils {
    
    // MARK: - Data Transformation
    
    
    
    
    // MARK: - Serialization

    public static func encode<T>(data: T) -> Data? {
        
        return try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
    }
    
    public static func decode<T>(data: Data) -> T? {

        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
    }
}
