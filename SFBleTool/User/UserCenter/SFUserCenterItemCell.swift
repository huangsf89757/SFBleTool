//
//  SFUserCenterItemCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/2.
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


// MARK: - SFUserCenterItemCell
class SFUserCenterItemCell: SFTableViewCell {
    // MARK: data
    var item: SFUserCenterItem? {
        didSet {
            guard let item = item else { return }
            iconImgView.image = item.image
            titleLabel.text = item.text
        }
    }
    
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.content()
        contentView.backgroundColor = R.color.content()
        customUI()
        separatorInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
    }
    
    // MARK: ui
    private lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    private lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .regular)
            view.textColor = R.color.title()
        }
    }()
    private lazy var detailImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.com.detail()
        }
    }()
    private func customUI() {
        contentView.addSubview(iconImgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailImgView)
        
        iconImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
            make.width.height.equalTo(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
        }
        detailImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
