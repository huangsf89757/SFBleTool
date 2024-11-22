//
//  UserCenterItem.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit

enum UserCenterItem {
    case centralManagerOptions
    case peripheralOptions
    
    case security
    
    var text: String {
        switch self {
        case .centralManagerOptions:
            return "centralManagerOptions"
        case .peripheralOptions:
            return "peripheralOptions"
        case .security:
            return "security"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .centralManagerOptions:
            return nil
        case .peripheralOptions:
            return nil
        case .security:
            return nil
        }
    }
}
