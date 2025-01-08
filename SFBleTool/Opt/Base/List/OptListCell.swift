//
//  OptListCell.swift
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

// MARK: - OptListCell
class OptListCell: SFCardTableViewCell {
    // MARK: block
    var selectBlcok: ((OptModel)->())?
    
    // MARK: data
    var model: OptModel? {
        didSet {
            guard let model = model else { return }
            update(model: model)
        }
    }
    var isEdit = false {
        didSet {
            isEditDidChanged()
        }
    }
    
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cardInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        cardJoin = false
        customUI()
    }
    
    // MARK: ui
    private lazy var selectBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(SFImage.UI.Select.nor, for: .normal)
            view.setImage(SFImage.UI.Select.sel, for: .selected)
            view.hitInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
            view.addTarget(self, action: #selector(selectBtnClicked), for: .touchUpInside)
            view.isHidden = true
        }
    }()
    private lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = SFColor.UI.title
        }
    }()
    private lazy var usingLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 10, weight: .regular)
            view.textColor = SFColor.UI.whiteAlways
            view.backgroundColor = SFColor.UI.theme
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            view.edgeInsert = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
            view.isHidden = true
            view.setContentHuggingPriority(.required, for: .horizontal)
            view.setContentCompressionResistancePriority(.required, for: .horizontal)
            view.text = SFText.Main.opt_list_using
        }
    }()
    private lazy var detailIcon: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = SFImage.UI.Com.detail
        }
    }()
    private func customUI() {
        contentView.addSubview(selectBtn)
        cardView.addSubview(nameLabel)
        cardView.addSubview(usingLabel)
        cardView.addSubview(detailIcon)
        
        selectBtn.snp.makeConstraints { make in
            make.centerY.equalTo(cardView)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        usingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.height.equalTo(16)
        }
        detailIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(usingLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(20)
        }
    }
    
    // MARK: func
    func update(model: OptModel) {
        selectBtn.isUserInteractionEnabled = model.selectable
        selectBtn.isSelected = model.isSelected
        nameLabel.text = model.name
        usingLabel.isHidden = !(model.isActive ?? false)
    }
    func isEditDidChanged() {
        if isEdit {
            cardInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 10)
            cardView.isUserInteractionEnabled = false
            selectBtn.isHidden = false
            detailIcon.isHidden = true
            detailIcon.snp.updateConstraints { make in
                make.trailing.equalToSuperview().offset(20)
            }
        } else {
            cardInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            cardView.isUserInteractionEnabled = true
            selectBtn.isHidden = true
            detailIcon.isHidden = false
            detailIcon.snp.updateConstraints { make in
                make.trailing.equalToSuperview().offset(-10)
            }
        }
    }
    func updateIsSelected() {
        model?.isSelected.toggle()
    }
    
}

// MARK: - Action
extension OptListCell {
    @objc private func selectBtnClicked() {
        guard let model = model else { return }
        updateIsSelected()
        selectBlcok?(model)
    }
}
