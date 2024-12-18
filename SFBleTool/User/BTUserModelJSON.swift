//
//  BTUserModelJSON.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/18.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Business
import SFBusiness
import SFUser
// Server
import SFLogger
// Third
import SwiftyJSON

// MARK: BTUserKey
public enum BTUserKey: String {
    case orderL
    case idL
    case createTimeL
    case updateTimeL
    
    case orderR
    case idR
    case createTimeR
    case updateTimeR
    
    case uid
    case account
    case state
    case pwd
    case nickname
    case gender
    case avatar
    case motto
    case phone
    case email
    case birthday
    case address
    
    case page
}
extension JSON {
    subscript(key: BTUserKey) -> JSON {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue
        }
    }
}


// MARK: - JSON <-> Model
extension BTUserModel {
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
        
        orderL = json[BTUserKey.orderL].int
        idL = json[BTUserKey.idL].string
        createTimeL = json[BTUserKey.createTimeL].string
        updateTimeL = json[BTUserKey.updateTimeL].string
        
        orderR = json[BTUserKey.orderR].int
        idR = json[BTUserKey.idR].string
        createTimeR = json[BTUserKey.createTimeR].string
        updateTimeR = json[BTUserKey.updateTimeR].string
        
        uid = json[BTUserKey.uid].string
        account = json[BTUserKey.account].string
        state = json[BTUserKey.state].int
        pwd = json[BTUserKey.pwd].string
        nickname = json[BTUserKey.nickname].string
        gender = json[BTUserKey.gender].int
        avatar = json[BTUserKey.avatar].string
        motto = json[BTUserKey.motto].string
        phone = json[BTUserKey.phone].string
        email = json[BTUserKey.email].string
        birthday = json[BTUserKey.birthday].string
        address = json[BTUserKey.address].string
        page = json[BTUserKey.page].int
    }
    
    /// 模型转字典
    public func toDict() -> [String: Any] {
        var json = JSON()
        
        json[BTUserKey.orderL].int = orderL
        json[BTUserKey.idL].string = idL
        json[BTUserKey.createTimeL].string = createTimeL
        json[BTUserKey.updateTimeL].string = updateTimeL

        json[BTUserKey.orderR].int = orderR
        json[BTUserKey.idR].string = idR
        json[BTUserKey.createTimeR].string = createTimeR
        json[BTUserKey.updateTimeR].string = updateTimeR

        json[BTUserKey.uid].string = uid
        json[BTUserKey.account].string = account
        json[BTUserKey.state].int = state
        json[BTUserKey.pwd].string = pwd
        json[BTUserKey.nickname].string = nickname
        json[BTUserKey.gender].int = gender
        json[BTUserKey.avatar].string = avatar
        json[BTUserKey.motto].string = motto
        json[BTUserKey.phone].string = phone
        json[BTUserKey.email].string = email
        json[BTUserKey.birthday].string = birthday
        json[BTUserKey.address].string = address
        json[BTUserKey.page].int = page
        
        return json.dictionaryObject ?? [:]
    }
}



