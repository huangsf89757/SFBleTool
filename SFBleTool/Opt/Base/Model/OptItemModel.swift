//
//  OptItemModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit

class OptItemModel {
    
    var item: OptItem = .client(.connect(.ancs))
    var value: String? = nil
    var selectable: Bool = true
    var isSelected: Bool = false
    
    init(item: OptItem) {
        self.item = item
    }
}
