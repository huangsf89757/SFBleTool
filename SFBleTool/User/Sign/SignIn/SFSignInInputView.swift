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
    // MARK: life cycle
    convenience init() {
        self.init(dir: .horizontal)
    }
    override init(dir: SFScrollView.Direction) {
        super.init(dir: .horizontal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    private lazy var codeView: SFSignInCodeInputView = {
        return SFSignInCodeInputView()
    }()
    
    private lazy var pwdView: SFSignInPwdInputView = {
        return SFSignInPwdInputView()
    }()
    
    private func customUI() {
        
    }
}
