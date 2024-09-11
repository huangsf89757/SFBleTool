//
//  SFSignInCodeInputView.swift
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

// MARK: - SFSignInCodeInputView
class SFSignInCodeInputView: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    private lazy var accountImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.user.sign.account()
        }
    }()
    private lazy var accountTextField: SFTextField = {
        return SFTextField().then { view in
            view.placeholder = R.string.localizable.user_signIn_input_account_ph()
            view.placeholderColor = R.color.placeholder()
            view.clearButtonMode = .whileEditing
        }
    }()
    private lazy var lineView: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.divider()
        }
    }()
    private lazy var codeImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.user.sign.code()
        }
    }()
    private lazy var codeTextField: SFTextField = {
        return SFTextField().then { view in
            view.placeholder = R.string.localizable.user_signIn_input_code_ph()
            view.placeholderColor = R.color.placeholder()
            view.clearButtonMode = .whileEditing
        }
    }()
    private lazy var sendCodeBtn: SFButton = {
        return SFButton().then { view in
            view.setTitleColor(R.color.theme(), for: .normal)
            view.setTitleColor(R.color.placeholder(), for: .selected)
            view.setTitle(R.string.localizable.user_signIn_action_sendCode(), for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }()
    
    private func customUI() {
        
    }
}
