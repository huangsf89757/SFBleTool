//
//  SFSignAccountFieldView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/12.
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

// MARK: - SFSignAccountFieldView
class SFSignAccountFieldView: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.user.sign.account()
        }
    }()
    private lazy var textField: SFTextField = {
        return SFTextField().then { view in
            view.placeholder = R.string.localizable.user_signIn_input_account_ph()
            view.placeholderColor = R.color.placeholder()
            view.clearButtonMode = .whileEditing
            view.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }()
    private func customUI() {
        addSubview(iconImgView)
        addSubview(textField)
        
        iconImgView.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(20)
        }
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(44)
        }
    }
}
