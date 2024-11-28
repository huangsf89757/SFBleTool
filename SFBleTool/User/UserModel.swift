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
    class var tableName: String {
        return "user"
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
    
    // MARK: User
    static var current: (any SFUser.UserDatanable)?
    var uid: String?
    var account: String?
    var nickname: String?
    var gender: Int? = 0
    var avatar: String?
    var motto: String?
    var phone: String?
    var email: String?
    var birthday: String?
    var address: String?
    
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
        case nickname
        case gender
        case avatar
        case motto
        case phone
        case email
        case birthday
        case address
        
        public static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(orderL, isPrimary: true, isAutoIncrement: true)
            BindColumnConstraint(idL, isNotNull: true, isUnique: true)
        }
    }
}
