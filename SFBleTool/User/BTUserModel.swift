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
    
    // MARK: BTUserModel
    /// 页面
    /// 0：entrance
    /// 1：client
    /// 2：server
    var page: Int?
    
    /// CodingKeys
    enum CodingKeys: String, CodingTableKey {
        public typealias Root = BTUserModel
        
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
        
        public static let objectRelationalMapping = TableBinding(CodingKeys.self) 
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

// MARK: - Database
extension BTUserModel {
    /// 更新用户信息
    func update() -> Bool {
        return false
//        guard let appDb = SFDatabase.appDb else { return false }
//        guard let idL = idL else { return false }
//        do {
//            let condition = BTUserModel.Properties.idL.is(idL)
//            try appDb.update(table: BTUserModel.table, on: BTUserModel.Properties.all, with: self, where: condition)
//            return true
//        } catch let error {
//            SFLogger.debug("[DB]", "[改]", "更新用户信息", "失败", error.localizedDescription)
//            return false
//        }
    }
}
