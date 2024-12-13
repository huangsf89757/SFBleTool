//
//  ClientDatabase.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/9.
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

// MARK: - App相关
extension SFClientDatabase {
    /// 创建App相关表
    static func createAppTables() {
        let logTag = "创建App相关表"
        SFDbLogger.info(tag: logTag, step: .begin, port: .client, type: .add, msgs: "")
        guard let appDb = getAppDb() else {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .add, msgs: "appDb=nil")
            return
        }
        do {
            try appDb.create(table: BTUserModel.table, of: BTUserModel.self)
            SFDbLogger.info(tag: logTag, step: .success, port: .client, type: .add, msgs: "")
        } catch let error {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .add, msgs: error.localizedDescription)
        }
    }
}

// MARK: - 用户相关
extension SFClientDatabase {
    /// 设置当前登录用户
    static func setActiveUser(_ user: BTUserModel) -> Bool {
        let logTag = "设置当前登录用户"
        SFDbLogger.info(tag: logTag, step: .begin, port: .client, type: .update, msgs: "")
        guard let appDb = getAppDb() else {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .update, msgs: "appDb=nil")
            return false
        }
        do {
            let condition = BTUserModel.Properties.state.is(AccountState.active.rawValue)
            var tmp = BTUserModel()
            tmp.stateEnum = .inactive
            try appDb.update(table: BTUserModel.table, on: [BTUserModel.Properties.state], with: tmp, where: condition)
           
            var activeUser = user
            activeUser.stateEnum = .active
            try appDb.insertOrReplace([activeUser], intoTable: BTUserModel.table)
            SFDbLogger.info(tag: logTag, step: .success, port: .client, type: .update, msgs: "")
            return true
        } catch let error {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .update, msgs: error.localizedDescription)
            return false
        }
    }
    
    /// 获取当前登录用户
    static func getActiveUser() -> BTUserModel? {
        let logTag = "获取当前登录用户"
        SFDbLogger.info(tag: logTag, step: .begin, port: .client, type: .find, msgs: "")
        guard let appDb = getAppDb() else {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .find, msgs: "appDb=nil")
            return nil
        }
        do {
            let condition = BTUserModel.Properties.state.is(AccountState.active.rawValue)
            let order = [BTUserModel.Properties.updateTimeL.order(.descending)]
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition, orderBy: order)
            if let user = user {
                SFDbLogger.info(tag: logTag, step: .success, port: .client, type: .find, msgs: "user=\(user)")
            } else {
                SFDbLogger.info(tag: logTag, step: .failure, port: .client, type: .find, msgs: "user=nil")
            }
            return user
        } catch let error {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .find, msgs: error.localizedDescription)
            return nil
        }
    }
    
    static func updateUser(_ user: BTUserModel) -> Bool {
        let logTag = "更新当前登录用户"
        SFDbLogger.info(tag: logTag, step: .begin, port: .client, type: .update, msgs: "")
        guard let uid = user.uid else {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .update, msgs: "uid=nil")
            return false
        }
        guard let appDb = getAppDb() else {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .update, msgs: "appDb=nil")
            return false
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            try appDb.update(table: BTUserModel.table, on: BTUserModel.Properties.all, with: user, where: condition)
            SFDbLogger.info(tag: logTag, step: .success, port: .client, type: .update, msgs: "")
            return true
        } catch let error {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .update, msgs: error.localizedDescription)
            return false
        }
    }
    
    /// 创建User相关表
    static func createUserTables() {
        let logTag = "创建User相关表"
        SFDbLogger.info(tag: logTag, step: .begin, port: .client, type: .add, msgs: "")
        guard let user = UserModel.active else {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .add, msgs: "UserModel.active=nil")
            return
        }
        guard let uid = user.uid else {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .add, msgs: "uid=nil")
            return
        }
        guard let userDb = getUserDb(with: uid) else {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .add, msgs: "userDb=nil")
            return
        }
        do {
            try userDb.create(table: OptModel.table, of: OptModel.self)
            SFDbLogger.info(tag: logTag, step: .success, port: .client, type: .add, msgs: "")
        } catch let error {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .add, msgs: error.localizedDescription)
        }
    }
}

