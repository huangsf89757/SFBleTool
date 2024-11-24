//
//  OptItemView.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: - OptItemView
class OptItemView: SFView {
    // MARK: var
    var selectBlcok: (()->())?
    var isEdit = false {
        didSet {
            isUserInteractionEnabled = isEdit
            selectBtn.isHidden = !isEdit
            titleLabel.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(isEdit ? 40 : 10)
            }
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = isEdit
        customUI()
    }
    
    // MARK: ui
    lazy var contentView: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.content
        }
    }()
    lazy var selectBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(SFImage.UI.Select.nor, for: .normal)
            view.setImage(SFImage.UI.Select.sel, for: .normal)
            view.hitInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
            view.addTarget(self, action: #selector(selectBtnClicked), for: .touchUpInside)
            view.isHidden = true
        }
    }()
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = SFColor.UI.title
            view.setContentHuggingPriority(.required, for: .horizontal)
        }
    }()
    lazy var subtitleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.subtitle
            view.setContentHuggingPriority(.required, for: .horizontal)
        }
    }()
    
    func customUI() {
        backgroundColor = .clear
        addSubview(contentView)
        contentView.addSubview(selectBtn)
        contentView.addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        selectBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

// MARK: - Action
extension OptItemView {
    @objc private func selectBtnClicked() {
        selectBlcok?()
    }
}
