//
//  UserCenterHeader.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/2.
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

// MARK: - UserCenterHeader
class UserCenterHeader: SFView {
    // MARK: block
    var didClickAvatarBlock: (()->())?
    
    // MARK: data
   
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var bgImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
        }
    }()
    private lazy var avatarImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = SFImage.User.user
            view.layer.cornerRadius = 40
            view.layer.masksToBounds = true
            view.backgroundColor = SFColor.UI.content
            view.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(avatarImgViewClicked))
            view.addGestureRecognizer(tap)
        }
    }()
    private lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .medium)
            view.textColor = SFColor.UI.title
        }
    }()
    private lazy var genderImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    private lazy var mottoLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.title
        }
    }()
    
    private func customUI() {
        backgroundColor = SFColor.UI.content
        addSubview(bgImgView)
        addSubview(avatarImgView)
        addSubview(nameLabel)
        addSubview(genderImgView)
        addSubview(mottoLabel)
        
        bgImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(250)
        }
        avatarImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImgView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }
        genderImgView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.width.height.equalTo(15)
            make.leading.equalTo(nameLabel.snp.trailing).offset(6)
            make.trailing.lessThanOrEqualToSuperview()
        }
        mottoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}

// MARK: - action
extension UserCenterHeader {
    @objc private func avatarImgViewClicked() {
        didClickAvatarBlock?()
    }
}
