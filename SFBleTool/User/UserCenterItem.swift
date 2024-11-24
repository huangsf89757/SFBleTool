//
//  UserCenterItem.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

enum UserCenterItem {
    case clientOptInit
    case clientOptScan
    case clientOptConnect
    
    
    var text: String {
        switch self {
        case .clientOptInit:
            return SFText.Main.userCenter_item_opt_initial
        case .clientOptScan:
            return SFText.Main.userCenter_item_opt_scan
        case .clientOptConnect:
            return SFText.Main.userCenter_item_opt_connect
        }
    }
    
    var image: UIImage? {
        switch self {
        case .clientOptInit:
            return SFImage.Main.User.Center.Opt.initial
        case .clientOptScan:
            return SFImage.Main.User.Center.Opt.scan
        case .clientOptConnect:
            return SFImage.Main.User.Center.Opt.connect
        }
    }
}
