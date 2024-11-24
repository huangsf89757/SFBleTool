//
//  OptItemView.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: - OptItemView
class OptItemView: SFView {
    // MARK: var
    var editEnable = false {
        didSet {
            isUserInteractionEnabled = editEnable
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = editEnable
        customUI()
    }
    
    // MARK: ui
    lazy var contentView: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.content
        }
    }()
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = SFColor.UI.title
            view.setContentHuggingPriority(.required, for: .horizontal)
        }
    }()
    lazy var subtitleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.subtitle
            view.setContentHuggingPriority(.required, for: .horizontal)
        }
    }()
    
    func customUI() {
        backgroundColor = .clear
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.bottom).offset(10)
            make.trailing.equalTo(contentView.snp.bottom).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
}
