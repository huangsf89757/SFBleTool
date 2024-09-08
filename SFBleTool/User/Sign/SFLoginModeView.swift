//
//  SFLoginModeView.swift
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

// MARK: - SFLoginMode
/// 登录方式
enum SFLoginMode {
    case code   // 验证码
    case pwd    // 密码
}

// MARK: - SFLoginModeView
class SFLoginModeView: SFView {
    // MARK: var
    var mode: SFLoginMode = .code
    
    // MARK: ui
    
}
