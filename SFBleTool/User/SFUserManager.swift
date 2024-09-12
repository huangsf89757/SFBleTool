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
    /// 操作记录
    var records = [SFUserRecordModel]()
    
    
}
