//
//  OptConfigCell.swift
//  SFBleTool
//
//  Created by hsf on 2025/1/9.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: - OptConfigCell
class OptConfigCell: SFCardTableViewCell {
    // MARK: block
    var changeBlock: ((OptModel)->())?
    
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
    private lazy var changeBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(SFImage.UI.Com.change, for: .normal)
            view.hitInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
            view.addTarget(self, action: #selector(changeBtnClicked), for: .touchUpInside)
            view.isHidden = true
        }
    }()
    private func customUI() {
        cardView.addSubview(nameLabel)
        cardView.addSubview(usingLabel)
        cardView.addSubview(detailIcon)
        contentView.addSubview(changeBtn)
        
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
        changeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(cardView)
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
    }
    
    // MARK: func
    func update(model: OptModel) {
        nameLabel.text = model.name
    }
    func isEditDidChanged() {
        if isEdit {
            cardInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 60)
            cardView.isUserInteractionEnabled = false
            changeBtn.isHidden = false
            detailIcon.isHidden = true
            detailIcon.snp.updateConstraints { make in
                make.trailing.equalToSuperview().offset(20)
            }
        } else {
            cardInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
            cardView.isUserInteractionEnabled = true
            changeBtn.isHidden = true
            detailIcon.isHidden = false
            detailIcon.snp.updateConstraints { make in
                make.trailing.equalToSuperview().offset(-10)
            }
        }
    }
}

// MARK: - Action
extension OptConfigCell {
    @objc private func changeBtnClicked() {
        guard let model = model else { return }
        changeBlock?(model)
    }
}
