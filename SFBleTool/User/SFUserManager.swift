//
//  SFUserManager.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/12.
//

import Foundation

class SFUserManager {
    // MARK: singleton
    static let shared = SFUserManager()
    private init() {}
    
    // MARK: user
    /// 当前登录的用户
    var curUser: SFUserModel?
    /// 近期登录的用户
    var recentUsers = [SFUserModel]()
    /// 管理员用户
    lazy var adminUser: SFUserModel = {
        let user = SFUserModel()
        user.uid = UUID().uuidString
        user.account = "SF000001"
        user.avatarUrl = ""
        user.nickname = "超级管理员"
        user.gender = .male
        user.motto = "不经历风雨，怎能见彩虹！"
        user.phone = "15557181105"
        user.email = "hsf89757@gmail.com"
        return user
    }()
    /// 操作记录
    var records = [SFUserRecordModel]()
    
   
}


