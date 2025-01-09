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
        let logTag = "内建数据"
        SFDatabaseLogger.info(port: .none, tag: logTag, step: .begin, type: .add, msgs: "")
        if SFUserDefault.buildInData {
            return
        }
        let user = BTUserModel()
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
        
        
        
        let serverSuccess = build(port: .server, user: user)
        if serverSuccess {
            let clientSuccess = build(port: .client, user: user)
            if clientSuccess {
                SFUserDefault.buildInData = true
                SFDatabaseLogger.info(port: .none, tag: logTag, step: .success, type: .add, msgs: "")
            } else {
                SFDatabaseLogger.info(port: .none, tag: logTag, step: .failure, type: .add, msgs: "build client data failed")
            }
        } else {
            SFDatabaseLogger.info(port: .none, tag: logTag, step: .failure, type: .add, msgs: "build server data failed")
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
                SFDatabaseLogger.error(port: .none, tag: logTag, step: .failure, type: .add, msgs: "appDb=nil")
                return false
            }
            do {
                try appDb.insertOrReplace([user], intoTable: BTUserModel.table)
                SFDatabaseLogger.info(port: .none, tag: logTag, step: .success, type: .add, msgs: "")
                return true
            } catch let error {
                SFDatabaseLogger.error(port: .none, tag: logTag, step: .failure, type: .add, msgs: error.localizedDescription)
                return false
            }
        }
        
    }
}
