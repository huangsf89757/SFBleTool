//
//  UserModel.swift
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

// MARK: UserModel
final class UserModel: UserDatanable, WCDBSwift.TableCodable {
    // MARK: Data
    class var table: String {
        return "user"
    }
    
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
    
    // MARK: UserDatanable
    var uid: String?
    var account: String?
    var pwd: String?
    var isActive: Bool?
    var nickname: String?
    var gender: Int? = 0
    var avatar: String?
    var motto: String?
    var phone: String?
    var email: String?
    var birthday: String?
    var address: String?
    
    // MARK: UserModel
    /// 当前活跃的用户
    static var active: UserModel? {
        didSet {
            SFDatabase.needUpdateUserDb = true
        }
    }
    /// 页面
    /// 0：entrance
    /// 1：client
    /// 2：server
    var page: Int?
    
    /// CodingKeys
    enum CodingKeys: String, CodingTableKey {
        public typealias Root = UserModel
        
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
        case pwd
        case isActive
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
            BindColumnConstraint(orderL, isPrimary: true, isAutoIncrement: true)
            BindColumnConstraint(idL, isNotNull: true, isUnique: true)
        }
    }
}

// MARK: - UserPage
extension UserModel {
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

// MARK: - Database
extension UserModel {
    /// 更新用户信息
    func update() -> Bool {
        guard let appDb = SFDatabase.appDb else { return false }
        guard let idL = idL else { return false }
        do {
            let condition = UserModel.Properties.idL.is(idL)
            try appDb.update(table: UserModel.table, on: UserModel.Properties.all, with: self, where: condition)
            return true
        } catch let error {
            SFLogger.debug("[DB]", "[改]", "更新用户信息", "失败", error.localizedDescription)
            return false
        }
    }
}
