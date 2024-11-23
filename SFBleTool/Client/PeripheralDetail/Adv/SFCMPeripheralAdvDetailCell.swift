//
//  SFCMPeripheralAdvDetailCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/15.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Server
import SFLogger


// MARK: - SFCMPeripheralAdvDetailCell
class SFCMPeripheralAdvDetailCell: SFTableViewCell {
    // MARK: data
    var item: SFCMPeripheralAdvDetailItem? {
        didSet {
            guard let item = item else { return }
            iconImgView.image = item.image
            titleLabel.text = item.text
            subtitleLabel.text = item.detail
            keyLabel.text = item.key
        }
    }
    
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = SFColor.UI.content
        contentView.backgroundColor = SFColor.UI.content
        customUI()
    }
    
    // MARK: ui
    private lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    private lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = SFColor.UI.title
        }
    }()
    private lazy var subtitleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.subtitle
        }
    }()
    private lazy var keyLabel: SFLabel = {
        return SFLabel().then { view in
            view.edgeInsert = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            view.font = .systemFont(ofSize: 8, weight: .medium)
            view.textColor = SFColor.UI.auxiliary
            view.backgroundColor = SFColor.UI.placeholder
            view.layer.cornerRadius = 5
            view.layer.masksToBounds = true
        }
    }()
    private lazy var valueView: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.background
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    private lazy var valueLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 20, weight: .regular)
            view.textColor = SFColor.UI.title
        }
    }()
    private func customUI() {
        contentView.addSubview(iconImgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueView)
        valueView.addSubview(valueLabel)
        
        iconImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImgView)
            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
            make.height.greaterThanOrEqualTo(iconImgView)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        keyLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        valueView.snp.makeConstraints { make in
            make.top.equalTo(keyLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
