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
    /// 配置客户端app数据库
    func configClientAppDatabase() {
        guard let clientAppDb = SFApp.clientDb() else { return }
        do {
            try clientAppDb.create(table: BTUserModel.table, of: BTUserModel.self)
        } catch let error {
            SFDbLogger.dbError(type: .add, msgs: "创建App相关表", "失败", error.localizedDescription)
        }
    }
    
    /// 获取当前登录用户
    func getActiveUser() {
        guard let clientAppDb = SFApp.clientDb() else { return }
        do {
            let condition = BTUserModel.Properties.isActive.is(true)
            let order = [BTUserModel.Properties.updateTimeL.asOrder(by: .descending)]
            let user: BTUserModel? = try clientAppDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition, orderBy: order)
            UserModel.active = user
        } catch let error {
            SFDbLogger.dbError(type: .find, msgs: "获取当前登录用户", "失败", error.localizedDescription)
        }
    }
    
    /// 配置user数据库
    func configClientUserDatabase() {
        guard let clientUserDb = UserModel.active?.clientDb else { return }
        do {
            try clientUserDb.create(table: OptModel.table, of: OptModel.self)
        } catch let error {
            SFDbLogger.dbError(type: .add, msgs: "创建User相关表", "失败", error.localizedDescription)
        }
    }
}
