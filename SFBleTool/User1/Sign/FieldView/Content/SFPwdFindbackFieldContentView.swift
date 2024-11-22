//
//  SFPwdFindbackFieldContentView.swift
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

// MARK: - SFPwdFindbackFieldContentView
class SFPwdFindbackFieldContentView: SFSignFieldContentView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var accountFieldView: SFSignAccountFieldView = {
        return SFSignAccountFieldView()
    }()
    private lazy var dividerView1: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.divider()
        }
    }()
    private lazy var codeFieldView: SFSignCodeFieldView = {
        return SFSignCodeFieldView()
    }()
    private lazy var dividerView2: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.divider()
        }
    }()
    private lazy var pwdFieldView: SFSignPwdFieldView = {
        return SFSignPwdFieldView()
    }()
    private lazy var dividerView3: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.divider()
        }
    }()
    private lazy var repwdFieldView: SFSignPwdFieldView = {
        return SFSignPwdFieldView()
    }()
    
    private func customUI() {
        addSubview(accountFieldView)
        addSubview(dividerView1)
        addSubview(codeFieldView)
        addSubview(dividerView2)
        addSubview(pwdFieldView)
        addSubview(dividerView3)
        addSubview(repwdFieldView)
        
        accountFieldView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }
        dividerView1.snp.makeConstraints { make in
            make.top.equalTo(accountFieldView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        codeFieldView.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        dividerView2.snp.makeConstraints { make in
            make.top.equalTo(codeFieldView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        pwdFieldView.snp.makeConstraints { make in
            make.top.equalTo(dividerView2.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        dividerView3.snp.makeConstraints { make in
            make.top.equalTo(pwdFieldView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        repwdFieldView.snp.makeConstraints { make in
            make.top.equalTo(dividerView3.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
