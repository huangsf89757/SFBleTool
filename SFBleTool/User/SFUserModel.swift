//
//  SFUserModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/3.
//

import Foundation
import UIKit

// MARK: - SFUserModel
class SFUserModel {
    // MARK: Gender
    enum Gender {
        case unknown
        case male
        case female
        
        var image: UIImage? {
            switch self {
            case .unknown:
                return nil
            case .male:
                return R.image.user.gender.male()
            case .female:
                return R.image.user.gender.female()
            }
        }
        
        var text: String {
            switch self {
            case .unknown:
                return R.string.localizable.user_info_gender_unknown()
            case .male:
                return R.string.localizable.user_info_gender_male()
            case .female:
                return R.string.localizable.user_info_gender_female()
            }
        }
    }
    
    // MARK: var
    // # 账号信息
    /// uid
    var uid: String?
    /// account
    var account: String?
    
    // # 基础信息
    /// 头像
    var avatarUrl: String?
    /// 昵称
    var nickname: String?
    /// 性别
    var gender: Gender = .unknown
    /// 座右铭
    var motto: String?
    
    // # 绑定信息
    /// 手机号
    var phone: String?
    /// 邮箱号
    var email: String?
    
    // # 附加信息
    /// 出生日期
    var birthday: Date?
    /// 所在地
    var address: String?
    
}
