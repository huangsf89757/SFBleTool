//
//  OptModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/25.
//

import Foundation
// Basic
import SFBase
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
    var orderL: Int = 0
    var idL: String = UUID().uuidString
    var createTimeL: String = SFDateFormatter.yyyyMMddHHmmssZ.string(from: Date())
    var updateTimeL: String = SFDateFormatter.yyyyMMddHHmmssZ.string(from: Date())
    
    // MARK: SFRemoteDatanable
    var orderR: Int?
    var idR: String?
    var createTimeR: String?
    var updateTimeR: String?
    
    // MARK: Opt
    var type: Int?
    var name: String?
    var itemValues: [Int: String]?
    var isActive: Bool = false
    
    // MARK: Select
    var selectable: Bool = true
    var isSelected: Bool = false

    var typeEnum: OptType {
        set {
            type = newValue.code
        }
        get {
            OptType(code: type ?? 0) ?? .none
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
        
        case orderL, idL, createTimeL, updateTimeL
        case orderR, idR, createTimeR, updateTimeR
        
        case type
        case name
        case itemValues
        case isActive
        
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)  {
            BindColumnConstraint(orderL, isPrimary: true, orderBy: .ascending, isAutoIncrement: true, isNotNull: true)
            BindColumnConstraint(idL, isUnique: true)
            BindIndex(name, namedWith: "_nameIndex")
        }
    }
}

// MARK: - CustomStringConvertible
extension OptModel: CustomStringConvertible {
    var description: String {
        let idL = idL
        let name = name ?? "<name>"
        let code = typeEnum.code
        let itemValues = String(describing: itemValues ?? [:])
        return "[OptModel]{idL:\(idL) name:\(name) code:\(code) itemValues:\(itemValues)}"
    }
}

// MARK: - Equatable
extension OptModel: Equatable {
    static func == (lhs: OptModel, rhs: OptModel) -> Bool {
        let equalL = (lhs.orderL == rhs.orderL) && (lhs.idL == rhs.idL) && (lhs.createTimeL == rhs.createTimeL)  && (lhs.updateTimeL == rhs.updateTimeL)
        let equalR = (lhs.orderR == rhs.orderR) && (lhs.idR == rhs.idR) && (lhs.createTimeR == rhs.createTimeR)  && (lhs.updateTimeR == rhs.updateTimeR)
        let equalS = (lhs.type == rhs.type) && (lhs.name == rhs.name) && (lhs.itemValues == rhs.itemValues)
        return equalL && equalR && equalS
    }
}

// MARK: - valuesToModels
extension OptModel {
    func valuesToModels() {
        let items = typeEnum.items
        var itemModels: [OptItemModel] = []
        for item in items {
            let itemModel = OptItemModel(item: item)
            setValue(itemValues?[item.code], for: itemModel)
            itemModels.append(itemModel)
        }
        self.itemModels = itemModels
    }
    func setValue(_ value: Any?, for itemModel: OptItemModel) {
        guard let value = value else { return }
        guard let string = value as? String else { return }
        itemModel.value = string
        itemModel.isSelected = true
    }
}

// MARK: - modelsToValues
extension OptModel {
    func modelsToValues() {
        guard selectedModels.count > 0 else {
            itemValues = [:]
            return
        }
        var itemValues = [Int: String]()
        for selectedModel in self.selectedModels {
            let code = selectedModel.item.code
            guard let value = selectedModel.value else {
                continue
            }
            itemValues[code] = value
        }
        self.itemValues = itemValues
    }
}

// MARK: - default
extension OptModel {
    func default_clientInitial() {
        defaultL()
        typeEnum = .client(.initial)
        valuesToModels()
    }
    func default_clientScan() {
        defaultL()
        typeEnum = .client(.scan)
        valuesToModels()
    }
    func default_clientConnect() {
        defaultL()
        typeEnum = .client(.connect)
        valuesToModels()
    }
}
