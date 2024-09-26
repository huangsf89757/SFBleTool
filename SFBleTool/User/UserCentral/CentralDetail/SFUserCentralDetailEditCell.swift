//
//  SFUserCentralDetailEditCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/18.
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


// MARK: - SFUserCentralDetailEditCell
class SFUserCentralDetailEditCell: SFTableViewCell {
    // MARK: data
    var item: SFUserCentralDetailItem? {
        didSet {
            guard let item = item else { return }
            titleLabel.text = item.text
        }
    }
    
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customUI()
    }
    
    // MARK: ui
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
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
            view.font = .systemFont(ofSize: 17, weight: .bold)
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
    private func customUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(detailImgView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        tipBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.width.height.equalTo(12)
            make.trailing.lessThanOrEqualTo(self.snp.centerX).offset(-5)
        }
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(self.snp.centerX).offset(5)
        }
        detailImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(valueLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(20)
        }
    }
}

extension SFUserCentralDetailEditCell {
    @objc private func tipBtnClicked() {
        SFAlert().show(alertStyle: .alert, headerStyle: .leading, title: "xxx", msg: "xxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxx")
    }
}
