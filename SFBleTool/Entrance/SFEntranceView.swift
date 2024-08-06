//
//  SFEntranceView.swift
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

// MARK: - SFEntranceView
class SFEntranceView: SFView {
    // MARK: var
    var isSelected = false {
        didSet {
            updateAppearance()
        }
    }
    var tapBlock: ((SFEntranceView) -> ())?
    
    lazy var selectImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 30, weight: .bold)
        }
    }()
    lazy var subtitleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 30, weight: .bold)
        }
    }()
    lazy var gotoImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SFColor.container
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
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    // MARK: appearance
    private func updateAppearance() {
        if isSelected {
            layer.borderColor = SFColor.primary?.cgColor
        } else {
            layer.borderColor = SFColor.placeholder?.cgColor
        }
    }
}

extension SFEntranceView {
    @objc private func tapAction() {
        tapBlock?(self)
    }
}
