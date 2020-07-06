//
//  String.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/5/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation


extension String {
    
    public var localize: String {
        NSLocalizedString(self, comment: "")
    }
}
