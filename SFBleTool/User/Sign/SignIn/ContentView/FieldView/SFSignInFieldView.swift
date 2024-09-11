//
//  SFSignInFieldView.swift
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

// MARK: - SFSignInFieldView
class SFSignInFieldView: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.background()
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    lazy var accountImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.user.sign.account()
        }
    }()
    lazy var accountTextField: SFTextField = {
        return SFTextField().then { view in
            view.placeholder = R.string.localizable.user_signIn_input_account_ph()
            view.placeholderColor = R.color.placeholder()
            view.clearButtonMode = .whileEditing
            view.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }()
    lazy var dividerView: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.divider()
        }
    }()
}
