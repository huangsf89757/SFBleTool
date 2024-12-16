//
//  ServerDatabase.swift
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

extension SFServerDatabase {
    /// 创建App相关表
    static func createAppTables() {
        let logTag = "创建App相关表"
        SFDatabaseLogger.info(port: .server, tag: logTag, step: .begin, type: .add, msgs: "")
        guard let appDb = getAppDb() else {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .add, msgs: "appDb=nil")
            return
        }
        do {
            try appDb.create(table: BTUserModel.table, of: BTUserModel.self)
            SFDatabaseLogger.info(port: .server, tag: logTag, step: .success, type: .add, msgs: "")
        } catch let error {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .add, msgs: error.localizedDescription)
        }
    }
    
    /// 设置当前登录用户
    static func setActiveUser(_ user: BTUserModel) -> Bool {
        let logTag = "设置当前登录用户"
        SFDatabaseLogger.info(port: .server, tag: logTag, step: .begin, type: .update, msgs: "")
        guard let appDb = getAppDb() else {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .update, msgs: "appDb=nil")
            return false
        }
        do {
            let condition = BTUserModel.Properties.state.is(AccountState.active.rawValue)
            let tmp = BTUserModel()
            tmp.stateEnum = .inactive
            try appDb.update(table: BTUserModel.table, on: [BTUserModel.Properties.state], with: tmp, where: condition)
           
            let activeUser = user
            activeUser.stateEnum = .active
            try appDb.insertOrReplace([activeUser], intoTable: BTUserModel.table)
            SFDatabaseLogger.info(port: .server, tag: logTag, step: .success, type: .update, msgs: "")
            return true
        } catch let error {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .update, msgs: error.localizedDescription)
            return false
        }
    }
    
    /// 获取当前登录用户
    static func getActiveUser() -> BTUserModel? {
        let logTag = "获取当前登录用户"
        SFDatabaseLogger.info(port: .server, tag: logTag, step: .begin, type: .find, msgs: "")
        guard let appDb = getAppDb() else {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .find, msgs: "appDb=nil")
            return nil
        }
        do {
            let condition = BTUserModel.Properties.state.is(AccountState.active.rawValue)
            let order = [BTUserModel.Properties.updateTimeL.order(.descending)]
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition, orderBy: order)
            if let user = user {
                SFDatabaseLogger.info(port: .server, tag: logTag, step: .success, type: .find, msgs: "user=\(user)")
            } else {
                SFDatabaseLogger.info(port: .server, tag: logTag, step: .failure, type: .find, msgs: "user=nil")
            }
            return user
        } catch let error {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .find, msgs: error.localizedDescription)
            return nil
        }
    }
    
    static func updateUser(_ user: BTUserModel) -> Bool {
        let logTag = "更新当前登录用户"
        SFDatabaseLogger.info(port: .server, tag: logTag, step: .begin, type: .update, msgs: "")
        guard let uid = user.uid else {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .update, msgs: "uid=nil")
            return false
        }
        guard let appDb = getAppDb() else {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .update, msgs: "appDb=nil")
            return false
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            try appDb.update(table: BTUserModel.table, on: BTUserModel.Properties.all, with: user, where: condition)
            SFDatabaseLogger.info(port: .server, tag: logTag, step: .success, type: .update, msgs: "")
            return true
        } catch let error {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .update, msgs: error.localizedDescription)
            return false
        }
    }
    
    /// 创建User相关表
    static func createUserTables(with uid: String) {
        let logTag = "创建User相关表(\(uid))"
        SFDatabaseLogger.info(port: .server, tag: logTag, step: .begin, type: .add, msgs: "")
        guard let userDb = getUserDb(with: uid) else {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .add, msgs: "userDb=nil")
            return
        }
        do {
            try userDb.create(table: OptModel.table, of: OptModel.self)
            SFDatabaseLogger.info(port: .server, tag: logTag, step: .success, type: .add, msgs: "")
        } catch let error {
            SFDatabaseLogger.error(port: .server, tag: logTag, step: .failure, type: .add, msgs: error.localizedDescription)
        }
    }
}

