//
//  SFUserModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/3.
//

import Foundation

// MARK: - SFUserModel
class SFUserModel {
    // MARK: Gender
    enum Gender {
        case male
        case female
        case unknown
    }
    
    // MARK: var
    // - 账号信息
    /// 账号id
    var id: String?
    /// 账号account
    var account: String?
    
    // - 基础信息
    /// 头像
    var avatarUrl: String?
    /// 昵称
    var nickname: String?
    /// 性别
    var gender: Gender = .unknown
    
    // - 绑定信息
    /// 手机号
    var phone: String?
    /// 邮箱号
    var email: String?
    
    // - 附加信息
    /// 出生日期
    var birthday: Date?
    /// 所在地
    var address: String?
    
}
