//
//  OptModelJSON.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/18.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// Server
import SFLogger
// Third
import SwiftyJSON

// MARK: OptKey
public enum OptKey: String {
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
    case itemValues
}
extension JSON {
    subscript(key: OptKey) -> JSON {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue
        }
    }
}


// MARK: - JSON <-> Model
extension OptModel {
    /// 字典转模型
    public convenience init(fromDict dict: [String: Any]?) {
        self.init()
        self.update(fromDict: dict)
    }
    
    /// 更新
    public func update(fromDict dict: [String: Any]?) {
        guard let dict = dict else { return }
        let json = JSON(dict as Any)
        if json.isEmpty { return }
        
        orderL = json[OptKey.orderL].int
        idL = json[OptKey.idL].string
        createTimeL = json[OptKey.createTimeL].string
        updateTimeL = json[OptKey.updateTimeL].string
        
        orderR = json[OptKey.orderR].int
        idR = json[OptKey.idR].string
        createTimeR = json[OptKey.createTimeR].string
        updateTimeR = json[OptKey.updateTimeR].string
        
        type = json[OptKey.type].int
        name = json[OptKey.name].string
//        itemValues = json[OptKey.itemValues].string // FIXME
    }
    
    /// 模型转字典
    public func toDict() -> [String: Any] {
        var json = JSON()
        
        json[OptKey.orderL].int = orderL
        json[OptKey.idL].string = idL
        json[OptKey.createTimeL].string = createTimeL
        json[OptKey.updateTimeL].string = updateTimeL

        json[OptKey.orderR].int = orderR
        json[OptKey.idR].string = idR
        json[OptKey.createTimeR].string = createTimeR
        json[OptKey.updateTimeR].string = updateTimeR

        json[OptKey.type].int = type
        json[OptKey.name].string = name
        
        return json.dictionaryObject ?? [:]
    }
}

