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
    /// 配置app数据库
    func configAppDatabase() {
        guard let appDb = SFDatabase.appDb() else { return }
        do {
            try appDb.create(table: UserModel.table, of: UserModel.self)
        } catch let error {
            SFDbLogger.dbError(type: .add, msgs: "创建App相关表", "失败", error.localizedDescription)
        }
    }
    
    /// 获取当前登录用户
    func getActiveUser() {
        guard let appDb = SFDatabase.appDb() else { return }
        do {
            let condition = UserModel.Properties.isActive.is(true)
            let order = [UserModel.Properties.updateTimeL.order(.descending)]
            let user: UserModel? = try appDb.getObject(on: UserModel.Properties.all, fromTable: UserModel.table, where: condition, orderBy: order)
            UserModel.active = user
        } catch let error {
            SFDbLogger.dbError(type: .find, msgs: "获取当前登录用户", "失败", error.localizedDescription)
        }
    }
    
    /// 配置user数据库
    func configUserDatabase() {
        guard let userDb = SFDatabase.userDb() else { return }
        do {
            try userDb.create(table: OptModel.table, of: OptModel.self)
        } catch let error {
            SFDbLogger.dbError(type: .add, msgs: "创建User相关表", "失败", error.localizedDescription)
        }
    }
}

extension SFDatabase {
    static var needUpdateUserDb = true
    private static var _userDb: Database?
    /// user数据库
    public static func userDb() -> Database? {
        if needUpdateUserDb == false, let _userDb = _userDb {
            return _userDb
        } else {
            needUpdateUserDb = false
            guard let user = UserModel.active else { return nil }
            guard let uid = user.uid else { return nil }
            let db = getUserDb(with: uid)
            _userDb = db
            return db
        }
    }
}
