//
//  UIDevice.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 8/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import UIKit

public enum UIDeviceModel: String {
    
    case iPodTouch_7thGen = "iPod touch (7th generation)"

    case iPhone6s = "iPhone 6s"
    case iPhone6sPlus = "iPhone 6s Plus"
    case iPhoneSE_1stGen = "iPhone SE (1st generation)"
    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneX = "iPhone X"
    case iPhoneXS = "iPhone XS"
    case iPhoneXSMax = "iPhone XS Max"
    case iPhoneXR = "iPhone XR"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhoneSE_2ndGen = "iPhone SE (2nd generation)"
    case iPhone12Mini = "iPhone 12 mini"
    case iPhone12 = "iPhone 12"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Pro Max"

    case iPad5thGen = "iPad (5th generation)"
    case iPad6thGen = "iPad (6th generation)"
    case iPad7thGen = "iPad (7th generation)"
    case iPadAir2 = "iPad Air 2"
    case iPadAir_3rdGen = "iPad Air (3rd generation)"
    case iPadMini4 = "iPad mini 4"
    case iPadMini_5thGen = "iPad mini (5th generation)"
    case iPadPro9i = "iPad Pro (9.7-inch)"
    case iPadPro10i = "iPad Pro (10.5-inch)"
    case iPadPro11i_1stGen = "iPad Pro (11-inch) (1st generation)"
    case iPadPro11i_2ndGen = "iPad Pro (11-inch) (2nd generation)"
    case iPadPro12i_1stGen = "iPad Pro (12.9-inch) (1st generation)"
    case iPadPro12i_2ndGen = "iPad Pro (12.9-inch) (2nd generation)"
    case iPadPro12i_3rdGen = "iPad Pro (12.9-inch) (3rd generation)"
    case iPadPro12i_4thGen = "iPad Pro (12.9-inch) (4th generation)"

    case UnidentifiedSimulator = "Unidentified Simulator"
    case Undefined = "Undefined"
}

extension UIDevice {

    private static let modelMapping: [ String : String ] = {
        
        guard let path = Bundle.main.path(forResource: "Devices", ofType: "plist") else { return [:] }
        
        guard let mapping = NSDictionary(contentsOfFile: path) as? [ String : String ] else { return [:] }
        
        return mapping
    }()
    
    public static let modelName: UIDeviceModel = {

        var systemInfo = utsname()
        
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("", { identifier, element in
            
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            
            return identifier + String(UnicodeScalar(UInt8(value)))
        })
        
        let simulatorModel = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]
        
        let modelNameStr = UIDevice.modelMapping[simulatorModel ?? identifier] ?? identifier
        
        return UIDeviceModel(rawValue: modelNameStr) ?? UIDeviceModel.Undefined
    }()

}
