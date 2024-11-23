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
    case optInit
    case optScan
    case optConnect
    
    
    var text: String {
        switch self {
        case .optInit:
            return SFText.Main.userCenter_item_opt_initial
        case .optScan:
            return SFText.Main.userCenter_item_opt_scan
        case .optConnect:
            return SFText.Main.userCenter_item_opt_connect
        }
    }
    
    var image: UIImage? {
        switch self {
        case .optInit:
            return SFImage.Main.User.Center.Opt.initial
        case .optScan:
            return SFImage.Main.User.Center.Opt.scan
        case .optConnect:
            return SFImage.Main.User.Center.Opt.connect
        }
    }
}
