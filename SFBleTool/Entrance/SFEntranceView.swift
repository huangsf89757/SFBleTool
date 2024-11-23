//
//  SFEntranceOptView.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
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

// MARK: - SFEntranceOptView
class SFEntranceOptView: SFView {
    // MARK: block
    var tapBlock: ((SFEntranceOptView) -> ())?
    
    // MARK: var
    var isSelected = false {
        didSet {
            updateAppearance()
        }
    }    
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SFColor.UI.content
        layer.cornerRadius = 10
        layer.borderWidth = 1
        updateAppearance()
        customUI()
    }
    
    // MARK: ui
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
//            view.image = R.image.com.goto()
        }
    }()
    lazy var clickBtn: SFButton = {
        return SFButton().then { view in
            view.addTarget(self, action: #selector(clickBtnAction), for: .touchUpInside)
        }
    }()
    private func customUI() {
        addSubview(selectImgView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(gotoImgView)
        addSubview(clickBtn)
        
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
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: appearance
    private func updateAppearance() {
        if isSelected {
            layer.borderColor = SFColor.UI.theme?.cgColor
//            selectImgView.image = R.image.com.select.sel()
            backgroundColor = SFColor.UI.theme?.withAlphaComponent(0.3)
        } else {
            layer.borderColor = SFColor.UI.placeholder?.cgColor
//            selectImgView.image = R.image.com.select.nor()
            backgroundColor = SFColor.UI.content
        }
    }
}

extension SFEntranceOptView {
    @objc private func clickBtnAction() {
        isSelected = true
        updateAppearance()
        tapBlock?(self)
    }
}
