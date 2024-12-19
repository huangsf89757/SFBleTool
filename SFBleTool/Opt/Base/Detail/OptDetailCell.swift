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

// MARK: - OptDetailCell
class OptDetailCell: SFTableViewCell {
    // MARK: var
    var selectBlcok: ((OptItemModel)->())?
    var isEdit = false {
        didSet {
            isEditDidChanged()
        }
    }
    
    // MARK: data
    var model: OptItemModel? {
        didSet {       
            guard let model = model else { return }
            update(model: model)
        }
    }
    
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        isUserInteractionEnabled = isEdit
        customUI()
    }
    
    // MARK: ui
    lazy var mainView: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.content
        }
    }()
    lazy var selectBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(SFImage.UI.Select.nor, for: .normal)
            view.setImage(SFImage.UI.Select.sel, for: .selected)
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
    lazy var descLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.subtitle
            view.setContentHuggingPriority(.required, for: .horizontal)
        }
    }()
    
    func customUI() {
        backgroundColorNor = .clear
        
        contentView.addSubview(mainView)
        mainView.addSubview(selectBtn)
        mainView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
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
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: func
    func update(model: OptItemModel) {
        selectBtn.isUserInteractionEnabled = model.selectable
        selectBtn.isSelected = model.isSelected
        titleLabel.text = model.item.title
        descLabel.text = model.item.desc
    }
    
    func isEditDidChanged() {
        isUserInteractionEnabled = isEdit
        let showSelect = isEdit || model?.isSelected == true
        selectBtn.isHidden = !showSelect
        titleLabel.snp.updateConstraints { make in
            if showSelect {
                make.leading.equalToSuperview().offset(40)
            } else {
                make.leading.equalToSuperview().offset(10)
            }
        }
    }
}

// MARK: - Action
extension OptDetailCell {
    @objc private func selectBtnClicked() {
        guard let model = model else { return }
        selectBlcok?(model)
    }
}
