//
//  OptModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/25.
//

import Foundation

class OptModel {
    var title: String?
    var desc: String?
    var itemModels: [OptItemModel] = []
    
    var selectedModels: [OptItemModel] {
        return itemModels.filter { model in
            model.isSelected == true
        }
    }
}
