//
//  SFUserCenterDetailFooterView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/27.
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


// MARK: - SFUserCenterDetailFooterView
class SFUserCenterDetailFooterView: SFView {
    // MARK: block
    var cancelBlock: (()->())?
    var saveBlock: (()->())?
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var cancelBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = R.color.background()
            view.setTitleColor(R.color.auxiliary(), for: .normal)
            view.setTitle(R.string.localizable.com_cancel(), for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.layer.borderWidth = 1
            view.layer.borderColor = R.color.placeholder()?.cgColor
            view.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var saveBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = R.color.theme()
            view.setTitleColor(R.color.whiteAlways(), for: .normal)
            view.setTitle(R.string.localizable.com_save(), for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.addTarget(self, action: #selector(saveBtnClicked), for: .touchUpInside)
        }
    }()
    private func customUI() {
        addSubview(cancelBtn)
        addSubview(saveBtn)
        
        cancelBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        saveBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(cancelBtn.snp.trailing).offset(20)
            make.width.equalTo(cancelBtn)
            make.height.equalTo(cancelBtn)
            make.top.equalToSuperview().offset(20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
}

// MARK: - Action
extension SFUserCenterDetailFooterView {
    @objc private func cancelBtnClicked() {
        cancelBlock?()
    }
    
    @objc private func saveBtnClicked() {
        saveBlock?()
    }
}
