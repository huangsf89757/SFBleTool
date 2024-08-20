//
//  SFCMSortModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/20.
//

import Foundation

class SFCMSortModel {
    // MARK: Sort
    enum Sort {
        case asc // 升序
        case des // 降序
    }
    
    // MARK: var
    var name: Sort = .asc
    var rssi: Sort = .asc
}
