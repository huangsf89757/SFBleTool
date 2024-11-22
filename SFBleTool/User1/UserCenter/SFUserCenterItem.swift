//
//  SFUserCenterItem.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/2.
//

import Foundation
import UIKit

enum SFUserCenterItem {
    case central
    case peripheral
    case security
    
    var text: String {
        switch self {
        case .central:
            return R.string.localizable.user_center_item_central()
        case .peripheral:
            return R.string.localizable.user_center_item_peripheral()
        case .security:
            return R.string.localizable.user_center_item_security()
        }
    }
    
    var image: UIImage? {
        switch self {
        case .central:
            return R.image.user.center.central()
        case .peripheral:
            return R.image.user.center.peripheral()
        case .security:
            return R.image.user.center.security()
        }
    }
}
