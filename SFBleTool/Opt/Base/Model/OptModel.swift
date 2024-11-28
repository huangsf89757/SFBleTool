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
final class OptModel: SFLocalDatanable, SFRemoteDatanable, WCDBSwift.TableCodable {
    // MARK: Data
    class var tableName: String {
        return "option"
    }
    
    // MARK: Local
    var orderL: Int?
    var idL: String?
    var createTimeL: String?
    var updateTimeL: String?
    
    // MARK: Remote
    var orderR: Int?
    var idR: String?
    var createTimeR: String?
    var updateTimeR: String?
    
    // MARK: Opt
    var type: Int?
    var name: String?
    var values: [Int: String]?

    private(set) var itemModels: [OptItemModel] = []
    var selectedModels: [OptItemModel] {
        return itemModels.filter { model in
            model.isSelected == true
        }
    }
    
    /// CodingKeys
    enum CodingKeys: String, CodingTableKey {
        public typealias Root = OptModel
        
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
        guard let string = value as? String else { return }
        itemModel.value = string
    }
}

// MARK: - modelsToValues
extension OptModel {
    func modelsToValues() {
        guard selectedModels.count > 0 else {
            values = [:]
            return
        }
        var values = [Int: String]()
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
