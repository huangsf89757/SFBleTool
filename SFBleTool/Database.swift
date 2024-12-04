//
//  Database.swift
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

extension AppDelegate {
    /// 创建App相关表
    func createClientAppTables() {
        let tag = "创建App相关表"
        guard let clientAppDb = SFApp.clientDb() else {
            SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", "clientAppDb=nil")
            return
        }
        do {
            try clientAppDb.create(table: BTUserModel.table, of: BTUserModel.self)
            SFDbLogger.info(port: .client, type: .add, msgs: tag, "成功")
        } catch let error {
            SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", error.localizedDescription)
        }
    }
    
    /// 获取当前登录用户
    func getActiveUser() -> BTUserModel? {
        let tag = "获取当前登录用户"
        guard let clientAppDb = SFApp.clientDb() else {
            SFDbLogger.error(port: .client, type: .find, msgs: tag, "失败", "clientAppDb=nil")
            return nil
        }
        do {
            let condition = BTUserModel.Properties.isActive.is(true)
            let order = [BTUserModel.Properties.updateTimeL.order(.descending)]
            let user: BTUserModel? = try clientAppDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition, orderBy: order)
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
    func createClientUserTables() {
        let tag = "创建User相关表"
        guard let user = UserModel.active else { return }
        guard let clientUserDb = user.clientDb else {
            SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", "clientUserDb=nil")
            return
        }
        do {
            try clientUserDb.create(table: OptModel.table, of: OptModel.self)
            SFDbLogger.info(port: .client, type: .add, msgs: tag, "成功")
        } catch let error {
            SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", error.localizedDescription)
        }
    }
}
