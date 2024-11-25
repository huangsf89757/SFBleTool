//
//  OptItemModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit

class OptItemModel {
    /// cell类型
    enum CellType {
        case string
        case bool
    }
    
    var cellType: CellType
    var item: OptItem = .client(.connect(.ancs))
    var value: Any? = nil
    var isSelected: Bool = false
    
    init(item: OptItem, cellType: CellType) {
        self.item = item
        self.cellType = cellType
    }
}
