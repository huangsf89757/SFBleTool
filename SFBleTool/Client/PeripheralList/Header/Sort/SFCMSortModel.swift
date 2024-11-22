//
//  SFCMSortModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/20.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// UI
import SFUI

class SFCMSortModel {
    // MARK: Type
    enum Medthod {
        case none
        case name
        case rssi
    }
    
    // MARK: Sort
    enum Sort {
        case none   // 未知
        case asc    // 升序
        case des    // 降序
        
        var image: UIImage? {
            return nil
//            switch self {
//            case .none:
//                return R.image.com.sort.none()
//            case .asc:
//                return R.image.com.sort.asc()
//            case .des:
//                return R.image.com.sort.des()
//            }
        }
        
        var color: UIColor? {
            switch self {
            case .none:
                return SFColor.UI.subtitle
            case .asc, .des:
                return SFColor.UI.title
            }
        }
        
        var font: UIFont? {
            switch self {
            case .none:
                return .systemFont(ofSize: 15, weight: .regular)
            case .asc, .des:
                return .systemFont(ofSize: 15, weight: .bold)
            }
        }
        
        mutating func `switch`() {
            switch self {
            case .none:
                self = .asc
            case .asc:
                self = .des
            case .des:
                self = .asc
            }
        }
    }
    
    // MARK: var
    var medthod: Medthod = .none
    var sort: Sort = .none
    
   
}
