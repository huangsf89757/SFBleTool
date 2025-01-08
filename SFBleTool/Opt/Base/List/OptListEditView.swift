//
//  OptListEditView.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/26.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

class OptListEditView: SFView {
    // MARK: - block
    var selectBlcok: ((OptModel)->())?
    var deleteBlcok: ((OptModel)->())?
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var selectBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(SFImage.UI.Select.nor, for: .normal)
            view.setImage(SFImage.UI.Select.sel, for: .selected)
            view.hitInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
            view.addTarget(self, action: #selector(selectBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
            view.textColor = SFColor.UI.title
            view.text = SFText.UI.select_all
        }
    }()
    private lazy var deleteBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = .red
            view.setTitleColor(.white, for: .normal)
            view.setTitle(SFText.UI.com_delete, for: .normal)
            view.hitInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
            view.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    
    private func customUI() {
        backgroundColor = SFColor.UI.content
        addSubview(selectBtn)
        addSubview(titleLabel)
        addSubview(deleteBtn)
        
        selectBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(selectBtn)
            make.leading.equalTo(selectBtn.snp.trailing).offset(0)
        }
        deleteBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.greaterThanOrEqualTo(70)
            make.width.lessThanOrEqualTo(120)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
        }
    }
}

// MARK: - Action
extension OptListEditView {
    @objc private func selectBtnClicked() {
        
    }
    
    @objc private func deleteBtnClicked() {
        
    }
}
