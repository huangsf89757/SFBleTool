//
//  SFEntranceOptView.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
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

// MARK: - SFEntranceOptView
class SFEntranceOptView: SFView {
    // MARK: var
    var isSelected = false {
        didSet {
            updateAppearance()
        }
    }
    var tapBlock: ((SFEntranceOptView) -> ())?
    
    lazy var selectImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 20, weight: .bold)
        }
    }()
    lazy var subtitleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }()
    lazy var gotoImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.com.goto()
        }
    }()
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.container()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        updateAppearance()
        customLayoutOfEntranceView()
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    private func customLayoutOfEntranceView() {
        addSubview(selectImgView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(gotoImgView)
        
        selectImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(selectImgView.snp.trailing).offset(10)
            make.trailing.equalTo(gotoImgView.snp.leading).offset(-10)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-20)
        }
        gotoImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    // MARK: appearance
    private func updateAppearance() {
        if isSelected {
            layer.borderColor = R.color.primary()?.cgColor
            selectImgView.image = R.image.com.select.sel()
            backgroundColor = R.color.secondary()?.withAlphaComponent(0.5)
        } else {
            layer.borderColor = R.color.placeholder()?.cgColor
            selectImgView.image = R.image.com.select.nor()
            backgroundColor = R.color.container()
        }
    }
}

extension SFEntranceOptView {
    @objc private func tapAction() {
        tapBlock?(self)
    }
}
