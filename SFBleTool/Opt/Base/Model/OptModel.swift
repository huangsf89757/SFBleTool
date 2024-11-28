//
//  OptModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/25.
//

import Foundation
// Business
import SFBusiness
// Third
import WCDBSwift

// MARK: - OptModel
class OptModel: SFRemoteDataModel {
    // MARK: var
    /// 静态表名
    override class var tableName: String {
        return "option"
    }
    
    var type: Int?
    var name: String?
    var values: [Int: Any]?
    
    private(set) var itemModels: [OptItemModel] = []
    var selectedModels: [OptItemModel] {
        return itemModels.filter { model in
            model.isSelected == true
        }
    }
    
    /// CodingKeys
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = SFRemoteDataModel
        
        case orderL
        case idL
        case createTimeL
        case updateTimeL
        
        case orderR
        case idR
        case createTimeR
        case updateTimeR
        
        case type
        case name
        case values
        
        public static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(orderL, isPrimary: true, isAutoIncrement: true)
            BindColumnConstraint(idL, isNotNull: true, isUnique: true)
        }
    }
}

// MARK: - valuesToModels
extension OptModel {
    func valuesToModels() {
        guard let type = type else { return }
        let codes = OptItem.getOptItemCodes(with: type)
        var itemModels: [OptItemModel] = []
        for code in codes {
            let itemModel = OptItemModel(item: OptItem(code: code))
            setValue(values?[code], for: itemModel)
            itemModels.append(itemModel)
        }
        self.itemModels = itemModels
    }
    func setValue(_ value: Any?, for itemModel: OptItemModel) {
        guard let value = value else { return }
        switch itemModel.item.valueType {
        case .string:
            guard let string = value as? String else { return }
            itemModel.value = string
        case .bool:
            guard let bool = value as? Bool else { return }
            itemModel.value = bool
        case .none:
            break
        }
    }
}

// MARK: - modelsToValues
extension OptModel {
    func modelsToValues() {
        guard selectedModels.count > 0 else {
            values = [:]
            return
        }
        var values = [Int: Any]()
        for selectedModel in self.selectedModels {
            let code = selectedModel.item.code
            guard let value = selectedModel.value else {
                continue
            }
            values[code] = value
        }
        self.values = values
    }
}

// MARK: - default
extension OptModel {
    func default_clientInitial() {
        type = 110
        valuesToModels()
    }
    func default_clientScan() {
        type = 120
        valuesToModels()
    }
    func default_clientConnect() {
        type = 130
        valuesToModels()
    }
}
