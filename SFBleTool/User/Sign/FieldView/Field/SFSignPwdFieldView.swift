//
//  SFSignPwdFieldView.swift
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

// MARK: - SFSignPwdFieldView
class SFSignPwdFieldView: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.user.sign.pwd()
        }
    }()
    private lazy var textField: SFTextField = {
        return SFTextField().then { view in
            view.placeholder = R.string.localizable.user_signIn_input_pwd_ph()
            view.placeholderColor = R.color.placeholder()
            view.clearButtonMode = .whileEditing
            view.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }()
    private lazy var eyeBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(R.image.user.sign.eye.close(), for: .normal)
            view.setImage(R.image.user.sign.eye.open(), for: .selected)
            view.addTarget(self, action: #selector(eyeBtnClicked), for: .touchUpInside)
        }
    }()
    private func customUI() {
        addSubview(iconImgView)
        addSubview(textField)
        addSubview(eyeBtn)
        
        iconImgView.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(20)
        }
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
            make.height.equalTo(44)
        }
        eyeBtn.snp.makeConstraints { make in
            make.top.equalTo(textField)
            make.bottom.equalTo(textField)
            make.leading.equalTo(textField.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.width.equalTo(60)
        }
    }
}

// MARK: - action
extension SFSignPwdFieldView {
    @objc private func eyeBtnClicked() {
        eyeBtn.toggleSelected()
        textField.isSecureTextEntry = !eyeBtn.isSelected
    }
}
