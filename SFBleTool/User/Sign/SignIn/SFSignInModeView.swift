//
//  SFSignInModeView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/11.
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
enum SFSignInMode: CaseIterable {
    case code   // 验证码
    case pwd    // 密码
    
    /// 描述
    var text: String {
        switch self {
        case .code:
            return R.string.localizable.user_signIn_mode_code()
        case .pwd:
            return R.string.localizable.user_signIn_mode_pwd()
        }
    }
}

// MARK: - SFSignInModeView
class SFSignInModeView: SFSegmentView {
    // MARK: life cycle
    convenience init() {
        let titles = [
            SFSignInMode.code.text,
            SFSignInMode.pwd.text,
        ]
        self.init(titles: titles, images: nil, selectedImages: nil)
    }
    
    private override init(direction: SFSegmentView.Direction = .horizontal, titles: [String?]?, images: [UIImage?]?, selectedImages: [UIImage?]? = nil) {
        super.init(direction: .horizontal, titles: titles, images: images, selectedImages: selectedImages)
        titleFont = .systemFont(ofSize: 14, weight: .regular)
        selectedTitleFont = .systemFont(ofSize: 14, weight: .bold)
    }
    
    
}
