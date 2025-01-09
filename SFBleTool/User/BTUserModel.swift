//
//  BTUserModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/28.
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
import WCDBSwift

// MARK: BTUserModel
final class BTUserModel: UserDatanable, WCDBSwift.TableCodable {
    // MARK: Data
    class var table: String {
        return "user"
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
    
    // MARK: UserDatanable
    var uid: String = UUID().uuidString
    var account: String?
    var state: Int = 0
    var pwd: String?
    var nickname: String?
    var gender: Int = 0
    var avatar: String?
    var motto: String?
    var phone: String?
    var email: String?
    var birthday: String?
    var address: String?
    
    // MARK: BTUserModel
    /// 页面
    /// 0：entrance
    /// 1：client
    /// 2：server
    var page: Int = 0
    
    /// CodingKeys
    enum CodingKeys: String, CodingTableKey {
        public typealias Root = BTUserModel
        
        case orderL, idL, createTimeL, updateTimeL
        case orderR, idR, createTimeR, updateTimeR
        
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
        
        public static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(orderL, isPrimary: true, orderBy: .ascending, isAutoIncrement: true, isNotNull: true, defaultTo: 0)
            BindColumnConstraint(idL, isUnique: true, defaultTo: UUID().uuidString)
            BindIndex(uid, namedWith: "_uidIndex", isUnique: true)
            // default
            BindColumnConstraint(createTimeL, defaultTo: SFDateFormatter.yyyyMMddHHmmssZ.string(from: Date()))
            BindColumnConstraint(updateTimeL, defaultTo: SFDateFormatter.yyyyMMddHHmmssZ.string(from: Date()))
            BindColumnConstraint(uid, defaultTo: UUID().uuidString)
            BindColumnConstraint(state, defaultTo: 0)
            BindColumnConstraint(gender, defaultTo: 0)
            BindColumnConstraint(page, defaultTo: 0)
        }
    }
}

// MARK: - KeyPath
extension BTUserModel {
    struct KeyPathProperty<Model> {
        let keyPath: WritableKeyPath<Model, Any?>
        let property: BTUserModel.Properties
        
        init<Value>(keyPath: WritableKeyPath<Model, Value>, property: BTUserModel.Properties) {
            self.keyPath = keyPath as! WritableKeyPath<Model, Any?>
            self.property = property
        }
    }
    static let keyPathMapping: [String: KeyPathProperty<BTUserModel>] = [
        "orderL": KeyPathProperty(keyPath: \BTUserModel.orderL, property: .orderL),
        "idL": KeyPathProperty(keyPath: \BTUserModel.idL, property: .idL),
        "createTimeL": KeyPathProperty(keyPath: \BTUserModel.createTimeL, property: .createTimeL),
        "updateTimeL": KeyPathProperty(keyPath: \BTUserModel.updateTimeL, property: .updateTimeL),
        
        "orderR": KeyPathProperty(keyPath: \BTUserModel.orderR, property: .orderR),
        "idR": KeyPathProperty(keyPath: \BTUserModel.idR, property: .idR),
        "createTimeR": KeyPathProperty(keyPath: \BTUserModel.createTimeR, property: .createTimeR),
        "updateTimeR": KeyPathProperty(keyPath: \BTUserModel.updateTimeR, property: .updateTimeR),

        "uid": KeyPathProperty(keyPath: \BTUserModel.uid, property: .uid),
        "account": KeyPathProperty(keyPath: \BTUserModel.account, property: .account),
        "state": KeyPathProperty(keyPath: \BTUserModel.state, property: .state),
        "pwd": KeyPathProperty(keyPath: \BTUserModel.pwd, property: .pwd),
        "nickname": KeyPathProperty(keyPath: \BTUserModel.nickname, property: .nickname),
        "gender": KeyPathProperty(keyPath: \BTUserModel.gender, property: .gender),
        "avatar": KeyPathProperty(keyPath: \BTUserModel.avatar, property: .avatar),
        "motto": KeyPathProperty(keyPath: \BTUserModel.motto, property: .motto),
        "phone": KeyPathProperty(keyPath: \BTUserModel.phone, property: .phone),
        "email": KeyPathProperty(keyPath: \BTUserModel.email, property: .email),
        "birthday": KeyPathProperty(keyPath: \BTUserModel.birthday, property: .birthday),
        "address": KeyPathProperty(keyPath: \BTUserModel.address, property: .address),
        "page": KeyPathProperty(keyPath: \BTUserModel.page, property: .page),
    ]
}

// MARK: - CustomStringConvertible
extension BTUserModel: CustomStringConvertible {
    var description: String {
        let idL = idL
        let uid = uid
        let account = account ?? "<account>"
        return "[BTUserModel]{\(idL): \(account) \(uid)}"
    }
}

// MARK: - UserPage
extension BTUserModel {
    enum UserPage: Int {
        case entrance = 0
        case client
        case server
    }
    var pageEnum: UserPage {
        set {
            page = newValue.rawValue
        }
        get {
            return UserPage(rawValue: page ?? 0) ?? .entrance
        }
    }
}

