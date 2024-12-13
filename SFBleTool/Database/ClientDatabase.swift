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

extension SFClientDatabase {
    /// 创建App相关表
    static func createAppTables() {
        let tag = "创建App相关表"
        guard let appDb = getAppDb() else {
            SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", "appDb=nil")
            return
        }
        do {
            try appDb.create(table: BTUserModel.table, of: BTUserModel.self)
            SFDbLogger.info(port: .client, type: .add, msgs: tag, "成功")
        } catch let error {
            SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", error.localizedDescription)
        }
    }
    
    /// 设置当前登录用户
    static func setActiveUser(_ user: BTUserModel) -> Bool {
        let tag = "设置当前登录用户"
        guard let appDb = getAppDb() else {
            SFDbLogger.error(port: .client, type: .find, msgs: tag, "失败", "appDb=nil")
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
            return true
        } catch let error {
            SFDbLogger.error(port: .client, type: .find, msgs: tag, "失败", error.localizedDescription)
            return false
        }
    }
    
    /// 获取当前登录用户
    static func getActiveUser() -> BTUserModel? {
        let tag = "获取当前登录用户"
        guard let appDb = getAppDb() else {
            SFDbLogger.error(port: .client, type: .find, msgs: tag, "失败", "appDb=nil")
            return nil
        }
        do {
            let condition = BTUserModel.Properties.state.is(AccountState.active.rawValue)
            let order = [BTUserModel.Properties.updateTimeL.order(.descending)]
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition, orderBy: order)
            if let user = user {
                SFDbLogger.info(port: .client, type: .find, msgs: tag, "成功", "user=\(user)")
            } else {
                SFDbLogger.info(port: .client, type: .find, msgs: tag, "成功", "user=nil")
            }
            return user
        } catch let error {
            SFDbLogger.error(port: .client, type: .find, msgs: tag, "失败", error.localizedDescription)
            return nil
        }
    }
    
    /// 创建User相关表
    static func createUserTables() {
        let tag = "创建User相关表"
        guard let user = UserModel.active else { return }
        guard let uid = user.uid else { return }
        guard let userDb = getUserDb(with: uid) else {
            SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", "userDb=nil")
            return
        }
//        do {
//            try userDb.create(table: OptModel.table, of: OptModel.self)
//            SFDbLogger.info(port: .client, type: .add, msgs: tag, "成功")
//        } catch let error {
//            SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", error.localizedDescription)
//        }
    }
}

