//
//  SFSignInInputView.swift
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


// MARK: - SFSignInInputView
class SFSignInInputView: SFScrollView {
    // MARK: ui
    private lazy var codeView: SFView = {
        return SFView()
    }()
    
    private lazy var pwdView: SFView = {
        return SFView()
    }()
}
