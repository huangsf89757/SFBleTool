//
//  SFUserInfoItem.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/14.
//

import Foundation
import UIKit

enum SFUserInfoItem {
    case account
    
    case avatar
    case nickname
    case gender
    case motto
    
    case phone
    case email
    
    case birthday
    case address
    
    var text: String {
        switch self {
        case .account:
            return R.string.localizable.user_info_account()
        case .avatar:
            return R.string.localizable.user_info_avatar()
        case .nickname:
            return R.string.localizable.user_info_nickname()
        case .gender:
            return R.string.localizable.user_info_gender()
        case .motto:
            return R.string.localizable.user_info_motto()
        case .phone:
            return R.string.localizable.user_info_phone()
        case .email:
            return R.string.localizable.user_info_email()
        case .birthday:
            return R.string.localizable.user_info_birthday()
        case .address:
            return R.string.localizable.user_info_address()
        }
    }
    
    var image: UIImage? {
        switch self {
        case .account:
            return R.image.user.info.account()
        case .avatar:
            return R.image.user.info.avatar()
        case .nickname:
            return R.image.user.info.nickname()
        case .gender:
            return R.image.user.info.gender()
        case .motto:
            return R.image.user.info.motto()
        case .phone:
            return R.image.user.info.phone()
        case .email:
            return R.image.user.info.email()
        case .birthday:
            return R.image.user.info.birthday()
        case .address:
            return R.image.user.info.address()
        }
    }
    
    var hasDetail: Bool {
        switch self {
        case .account:
            return false
        case .avatar:
            return false
        case .nickname:
            return true
        case .gender:
            return true
        case .motto:
            return true
        case .phone:
            return true
        case .email:
            return true
        case .birthday:
            return true
        case .address:
            return true
        }
    }
}
