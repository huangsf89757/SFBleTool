//
//  SFUserRecordModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/12.
//

import Foundation

// MARK: - SFUserRecordModel
class SFUserRecordModel {
    // MARK: 操作类型
    enum Types {
        case signIn             // 登录
        case signOut            // 登出
        case pwdFindback        // 密码找回
        case pwdModify          // 修改密码
    }
    
    // MARK: var
    var uid: String?
    /// 操作类型
    var type: Types = .signIn
    /// 操作时间
    var time = Date()
}
