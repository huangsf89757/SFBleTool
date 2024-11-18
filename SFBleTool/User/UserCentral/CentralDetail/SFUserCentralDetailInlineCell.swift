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
    override func customUI() {
        super.customUI()
        valueLabel.textAlignment = .right
        valueLabel.backgroundColor = .clear
        valueLabel.layer.cornerRadius = 0
        valueLabel.layer.masksToBounds = true
        cardView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.greaterThanOrEqualTo(tipBtn.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

