//
//  SFUserCentralDetailCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/16.
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


// MARK: - SFUserCentralDetailCell
class SFUserCentralDetailCell: SFCardTableViewCell {
    // MARK: data
    var isEdit = false {
        didSet {
            UIView.animate(withDuration: 1) {
                self.cardRadius = self.isEdit ? 0 : 10
                self.cardInset = self.isEdit ? .zero : UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                self.cardView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(self.cardInset.top)
                    make.leading.equalToSuperview().offset(self.cardInset.left)
                    make.trailing.equalToSuperview().offset(-self.cardInset.right)
                    make.bottom.equalToSuperview().offset(-self.cardInset.bottom)
                }
                self.detailImgView.isHidden = self.isEdit ? false : true
                self.tipBtn.snp.updateConstraints { make in
                    make.trailing.lessThanOrEqualToSuperview().offset(self.isEdit ? -30 : -10)
                }
                self.valueLabel.snp.updateConstraints { make in
                    make.trailing.equalToSuperview().offset(self.isEdit ? -30 : -10)
                }
            }
        }
    }
    var item: SFUserCentralDetailItem? {
        didSet {
            guard let item = item else { return }
            titleLabel.text = item.text
        }
    }
    
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColorNor = R.color.background()
        backgroundColorSel = R.color.background()
        customUI()
    }
    
    override var position: SFTableViewCell.Position? {
        didSet {
            if position == .first || position == .mid {
                customSeparator.isHidden = false
            } else {
                customSeparator.isHidden = true
            }
        }
    }
    
    // MARK: ui
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .regular)
            view.textColor = R.color.title()
            view.numberOfLines = 0
        }
    }()
    lazy var tipBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(R.image.com.tip(), for: .normal)
            view.addTarget(self, action: #selector(tipBtnClicked), for: .touchUpInside)
            view.hitInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        }
    }()
    lazy var valueLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .bold)
            view.textColor = R.color.subtitle()
            view.numberOfLines = 0
        }
    }()
    lazy var detailImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.com.detail()
        }
    }()
    func customUI() {
        cardView.addSubview(titleLabel)
        cardView.addSubview(tipBtn)
        cardView.addSubview(detailImgView)
        cardView.addSubview(customSeparator)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.height.greaterThanOrEqualTo(20)
        }
        tipBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.width.height.equalTo(12)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }
        detailImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(14)
        }
        customSeparator.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

extension SFUserCentralDetailCell {
    @objc private func tipBtnClicked() {
        SFAlert().show(alertStyle: .alert, headerStyle: .leading, title: "xxx", msg: "xxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxx")
    }
}
