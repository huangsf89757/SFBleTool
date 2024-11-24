//
//  PeripheralListSortModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/20.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

class PeripheralListSortModel {
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
            switch self {
            case .none:
                return SFImage.UI.Sort.none
            case .asc:
                return SFImage.UI.Sort.asc
            case .des:
                return SFImage.UI.Sort.des
            }
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
