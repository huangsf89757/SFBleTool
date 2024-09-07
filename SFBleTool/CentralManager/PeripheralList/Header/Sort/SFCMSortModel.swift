//
//  SFCMSortModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/20.
//

import Foundation
import UIKit

class SFCMSortModel {
    // MARK: Sort
    enum Sort {
        case none   // 未知
        case asc    // 升序
        case des    // 降序
        
        var image: UIImage? {
            switch self {
            case .none:
                return R.image.com.sort.none()
            case .asc:
                return R.image.com.sort.asc()
            case .des:
                return R.image.com.sort.des()
            }
        }
        
        var color: UIColor? {
            switch self {
            case .none:
                return R.color.subtitle()
            case .asc:
                return R.color.title()
            case .des:
                return R.color.title()
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
    var name: Sort = .none
    var rssi: Sort = .none
}
