//
//  SFPwdFindbackVC.swift
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

// MARK: - SFPwdFindbackVC
class SFPwdFindbackVC: SFScrollViewController {
    // MARK: block
    
    
    // MARK: life cycle
    convenience init() {
        self.init(dir: .vertical)
    }
    
    private override init(dir: SFScrollView.Direction) {
        super.init(dir: dir)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.user_pwdFindback()
        customUI()
    }
    
    // MARK: ui
    private lazy var fieldView: SFPwdFindbackFieldContentView = {
        return SFPwdFindbackFieldContentView()
    }()
    private lazy var findbackBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = R.color.theme()
            view.setTitleColor(R.color.whiteAlways(), for: .normal)
            view.setTitle(R.string.localizable.user_sign_in(), for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    
    private func customUI() {
        scrollView.contentView.addSubview(fieldView)
        scrollView.contentView.addSubview(findbackBtn)
        
        fieldView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        findbackBtn.snp.makeConstraints { make in
            make.top.equalTo(fieldView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().offset(-100)
        }
    }
}

