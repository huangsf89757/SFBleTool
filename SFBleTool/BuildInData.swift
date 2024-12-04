//
//  BuildInData.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/4.
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
    func buildInData() {
        let hasData = UserDefaults.standard.bool(forKey: UserDefaultKey.buildInData)
        if hasData {
            return
        }
        var user = BTUserModel()
        user.defaultL()
        user.defaultR()
        user.uid = UUID().uuidString
        user.account = BTUserModel.generateRandomAccount()
        user.isActive = true
        user.pwd = "Sf123456".sf.sha256()
        user.nickname = "阿七"
        user.genderEnum = .male
//        user.avatar = ""
        user.motto = "不经历风雨，怎能见彩虹。"
        user.phone = "15557181105"
        user.email = "hsf89757@gmail.com"
        user.birthday = "2000/01/01"
        user.address = "浙江省杭州市余杭区"
        user.pageEnum = .entrance
        
        let tag = "内建数据"
        let clientSuccess = buildClient(user: user)
        let serverSuccess = buildServer(user: user)
        if clientSuccess, serverSuccess {
            UserDefaults.standard.setValue(true, forKey: UserDefaultKey.buildInData)
            SFLogger.info(tag, "成功")
        }
       
        func buildClient(user: BTUserModel) -> Bool {
            guard let clientAppDb = SFApp.clientDb() else {
                SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", "clientAppDb=nil")
                return false
            }
            do {
                try clientAppDb.insertOrReplace([user], intoTable: BTUserModel.table)
                SFDbLogger.info(port: .client, type: .add, msgs: tag, "成功")
                return true
            } catch let error {
                SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", error.localizedDescription)
                return false
            }
        }
        
        func buildServer(user: BTUserModel) -> Bool {
            guard let serverAppDb = SFApp.serverDb() else {
                SFDbLogger.error(port: .server, type: .add, msgs: tag, "失败", "serverAppDb=nil")
                return false
            }
            do {
                try serverAppDb.insertOrReplace([user], intoTable: BTUserModel.table)
                SFDbLogger.info(port: .server, type: .add, msgs: tag, "成功")
                return true
            } catch let error {
                SFDbLogger.error(port: .server, type: .add, msgs: tag, "失败", error.localizedDescription)
                return false
            }
        }
    }
}
