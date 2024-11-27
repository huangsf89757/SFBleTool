//
//  OptDetailHeader.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/25.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

class OptDetailHeader: SFTableViewHeaderFooterView {
    
    // MARK: life cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        customUI()
    }
    
    // MARK: ui
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 30, weight: .bold)
            view.textColor = SFColor.UI.title
            view.textAlignment = .center
        }
    }()
    lazy var descLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
            view.textColor = SFColor.UI.subtitle
            view.textAlignment = .center
        }
    }()
    private func customUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
