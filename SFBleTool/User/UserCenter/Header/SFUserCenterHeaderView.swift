//
//  SFUserCenterHeaderView.swift
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


// MARK: - SFUserCenterHeaderView
class SFUserCenterHeaderView: SFView {
    // MARK: data
    var model: SFUserModel? {
        didSet {
            guard let model = model else { return }
            if let avatarUrl = model.avatarUrl {
                
            } else {
                avatarImgView.image = nil
            }
            nameLabel.text = model.nickname
            genderImgView.image = model.gender.image
            mottoLabel.text = model.motto
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: ui
    private lazy var bgImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFill
            view.image = R.image.user.center.bg()
            view.clipsToBounds = true
        }
    }()
    private lazy var avatarImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.layer.cornerRadius = 40
            view.layer.masksToBounds = true
            view.backgroundColor = R.color.white()
        }
    }()
    private lazy var nameView: SFView = {
        return SFView()
    }()
    private lazy var genderImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    private lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .medium)
            view.textColor = R.color.title()
        }
    }()
    private lazy var mottoLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = R.color.subtitle()
        }
    }()
    
    private func customUI() {
        addSubview(bgImgView)
        addSubview(avatarImgView)
        addSubview(nameView)
        addSubview(mottoLabel)
        nameView.addSubview(nameLabel)
        nameView.addSubview(genderImgView)
        
        bgImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(250)
        }
        avatarImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        nameView.snp.makeConstraints { make in
            make.top.equalTo(avatarImgView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }
        mottoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-30)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        genderImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.width.height.equalTo(20)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
    
}

