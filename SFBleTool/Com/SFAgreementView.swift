//
//  SFAgreementView.swift
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


// MARK: - SFAgreementView
class SFAgreementView: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        let hitInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        self.hitInsets = hitInsets
        checkBoxBtn.hitInsets = hitInsets
        customUI()
    }
    
    // MARK: ui
    private lazy var checkBoxBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(R.image.com.checkbox.nor(), for: .normal)
            view.setImage(R.image.com.checkbox.sel(), for: .selected)
            view.addTarget(self, action: #selector(checkBoxBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = R.color.subtitle()
            let text = R.string.localizable.user_signIn_agreement(R.string.localizable.user_signIn_agreement_term(), R.string.localizable.user_signIn_agreement_policy())
            view.text = text
        }
    }()
    
    private func customUI() {
        addSubview(checkBoxBtn)
        addSubview(titleLabel)
        
        checkBoxBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkBoxBtn.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - action
extension SFAgreementView {
    @objc private func checkBoxBtnClicked() {
        checkBoxBtn.toggleSelected()
    }
}
