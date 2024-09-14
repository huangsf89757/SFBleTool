//
//  SFUserInfoCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/14.
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


// MARK: - SFUserInfoCell
class SFUserInfoCell: SFTableViewCell {
    // MARK: data
    var item: SFUserInfoItem? {
        didSet {
            guard let item = item else { return }
            iconImgView.image = item.image
            titleLabel.text = item.text
            detailImgView.snp.updateConstraints { make in
                make.trailing.equalToSuperview().offset(item.hasDetail ? -10 : 20)
            }
            layoutIfNeeded()
        }
    }
    
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.background()
        contentView.backgroundColor = R.color.background()
        separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        customUI()
    }
    
    // MARK: ui
    lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .regular)
            view.textColor = R.color.title()
        }
    }()
    lazy var detailImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.com.detail()
        }
    }()
    func customUI() {
        addSubview(iconImgView)
        addSubview(titleLabel)
        addSubview(detailImgView)
        
        iconImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
            make.width.height.equalTo(25)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
        }
        detailImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
