//
//  UserCenterItem.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit

enum UserCenterItem {
    case centralManagerInitializationOptions
    case peripheralConnectionOptions
    case peripheralScanningOptions
    
    
    var text: String {
        switch self {
        case .centralManagerInitializationOptions:
            return "centralManagerInitializationOptions"
        case .peripheralConnectionOptions:
            return "peripheralConnectionOptions"
        case .peripheralScanningOptions:
            return "peripheralScanningOptions"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .centralManagerInitializationOptions:
            return nil
        case .peripheralScanningOptions:
            return nil
        case .peripheralScanningOptions:
            return nil
        }
    }
}
