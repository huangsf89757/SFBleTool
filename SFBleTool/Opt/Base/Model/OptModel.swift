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
    class var table: String {
        return "option"
    }
    var isAutoIncrement: Bool = true
    var lastInsertedRowID: Int64 = 0
    
    // MARK: SFLocalDatanable
    var orderL: Int?
    var idL: String?
    var createTimeL: String?
    var updateTimeL: String?
    
    // MARK: SFRemoteDatanable
    var orderR: Int?
    var idR: String?
    var createTimeR: String?
    var updateTimeR: String?
    
    // MARK: Opt
    var type: Int?
    var name: String?
    var values: [Int: String]?

    var typeEnum: OptType {
        set {
            type = newValue.code
        }
        get {
            OptType(code: type ?? 0)
        }
    }
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
        
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)  {
            BindColumnConstraint(orderL, isPrimary: true, orderBy: .ascending, isAutoIncrement: true, isNotNull: true, defaultTo: 0)
            BindColumnConstraint(idL, isUnique: true)
            BindIndex(name, namedWith: "_nameIndex")
        }
    }
}

// MARK: - valuesToModels
extension OptModel {
    func valuesToModels() {
        let items = typeEnum.items
        var itemModels: [OptItemModel] = []
        for item in items {
            let itemModel = OptItemModel(item: item)
            setValue(values?[item.code], for: itemModel)
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
        typeEnum = .client(.initial)
        valuesToModels()
    }
    func default_clientScan() {
        typeEnum = .client(.scan)
        valuesToModels()
    }
    func default_clientConnect() {
        typeEnum = .client(.connect)
        valuesToModels()
    }
}
