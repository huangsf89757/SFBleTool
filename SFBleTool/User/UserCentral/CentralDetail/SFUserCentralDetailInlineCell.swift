//
//  SFUserCentralDetailInlineCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/27.
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


// MARK: - SFUserCentralDetailInlineCell
class SFUserCentralDetailInlineCell: SFUserCentralDetailCell {
    // MARK: data
    
    
    // MARK: ui
    lazy var valueLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = R.color.subtitle()
            view.numberOfLines = 0
        }
    }()
    override func customUI() {
        super.customUI()
        cardView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.greaterThanOrEqualTo(tipBtn.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

