//
//  SFSignInPwdContentView.swift
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


// MARK: - SFSignInPwdContentView
class SFSignInPwdContentView: SFView {
    // MARK: block
    var forgetPwdBlock: (()->())?
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var fieldView: SFSignInPwdFieldContentView = {
        return SFSignInPwdFieldContentView()
    }()
    private lazy var tipLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = R.color.subtitle()
            view.text = R.string.localizable.user_signIn_tip_pwd()
        }
    }()
    private lazy var forgetPwdBtn: SFButton = {
        return SFButton().then { view in
            view.setTitle(R.string.localizable.user_signIn_action_forgetPwd(), for: .normal)
            view.setTitleColor(R.color.theme(), for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
            view.addTarget(self, action: #selector(forgetPwdBtnClicked), for: .touchUpInside)
        }
    }()
    
    private func customUI() {
        addSubview(fieldView)
        addSubview(tipLabel)
        addSubview(forgetPwdBtn)
        
        fieldView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(fieldView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(5)
            make.bottom.lessThanOrEqualToSuperview()
        }
        forgetPwdBtn.snp.makeConstraints { make in
            make.top.equalTo(fieldView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.lessThanOrEqualToSuperview()
            make.leading.greaterThanOrEqualTo(tipLabel.snp.trailing).offset(10)
        }
    }
}

// MARK: - action
extension SFSignInPwdContentView {
    @objc private func forgetPwdBtnClicked() {
        forgetPwdBlock?()
    }
}
