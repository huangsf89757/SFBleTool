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

extension SFDatabase {
    static func buildInData() {
        let hasData = UserDefaults.standard.bool(forKey: UserDefaultKey.buildInData)
        if hasData {
            return
        }
        var user = BTUserModel()
        user.defaultL()
        user.defaultR()
        user.uid = UUID().uuidString
        user.account = "SF0001"
        user.stateEnum = .inactive
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
        let serverSuccess = build(port: .server, user: user)
        if serverSuccess {
            let clientSuccess = build(port: .client, user: user)
            if clientSuccess {
                UserDefaults.standard.setValue(true, forKey: UserDefaultKey.buildInData)
                SFDbLogger.info(port: .none, type: .add, msgs: tag, "成功")
            } else {
                SFDbLogger.info(port: .none, type: .add, msgs: tag, "失败", "build client data failed")
            }
        } else {
            SFDbLogger.info(port: .none, type: .add, msgs: tag, "失败", "build server data failed")
        }
        
        func build(port: SFPort, user: BTUserModel) -> Bool {
            var appDb: Database?
            switch port {
            case .none:
                appDb = nil
            case .client:
                appDb = SFClientDatabase.getAppDb()
            case .server:
                appDb = SFServerDatabase.getAppDb()
            }
            guard let appDb = appDb else {
                SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", "appDb=nil")
                return false
            }
            do {
                try appDb.insertOrReplace([user], intoTable: BTUserModel.table)
                SFDbLogger.info(port: .client, type: .add, msgs: tag, "成功")
                return true
            } catch let error {
                SFDbLogger.error(port: .client, type: .add, msgs: tag, "失败", error.localizedDescription)
                return false
            }
        }
        
    }
}
