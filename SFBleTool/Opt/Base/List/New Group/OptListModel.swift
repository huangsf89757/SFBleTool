//
//  OptListModel.swift
//  SFBleTool
//
//  Created by hsf on 2025/1/22.
//

import Foundation
// Basic
import SFBase
// UI
import SFUI

// MARK: - OptListModel
class OptListModel: SFEditItemArrayModelable {
    // MARK: var
    var editable: Bool
    var items: [any SFUI.SFEditItemModelable]
    
    // MARK: init
    init(editable: Bool, items: [any SFUI.SFEditItemModelable]) {
        self.editable = editable
        self.items = items
    }
    
    // MARK: func
    func backup() -> Self {
        let items_backup = items.map { item in
            item.backup()
        }
        return OptListModel(editable: editable, items: items_backup) as! Self
    }
    
    // MARK: Equatable
    static func == (lhs: OptListModel, rhs: OptListModel) -> Bool {
        return true
    }
    
}

// MARK: - OptListItemModel
class OptListItemModel: SFEditItemModelable {
    // MARK: var
    var selectable: Bool
    var isSelected: Bool
    var opt: OptModel
    
    // MARK: init
    init(selectable: Bool, isSelected: Bool, opt: OptModel) {
        self.selectable = selectable
        self.isSelected = isSelected
        self.opt = opt
    }
    
    // MARK: func
    func backup() -> Self {
        return OptListItemModel(selectable: selectable, isSelected: isSelected, opt: opt) as! Self
    }
    
    // MARK: Equatable
    static func == (lhs: OptListItemModel, rhs: OptListItemModel) -> Bool {
        return true
    }
}
