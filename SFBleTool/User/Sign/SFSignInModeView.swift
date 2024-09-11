//
//  SFSignInModeView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/3.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// UI
import SFUI
// Server
import SFLogger

// MARK: - SFSignInMode
/// 登录方式
enum SFSignInMode {
    case code   // 验证码
    case pwd    // 密码
}

// MARK: - SFSignInModeView
class SFSignInModeView: SFView {
    // MARK: var
    var mode: SFSignInMode = .code
    
    // MARK: ui
    
}
