//
//  SFUserCentralDetailOutlineCell.swift
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


// MARK: - SFUserCentralDetailOutlineCell
class SFUserCentralDetailOutlineCell: SFUserCentralDetailCell {
    // MARK: data    
  
    
    // MARK: ui
    override func customUI() {
        valueLabel.textAlignment = .center
        valueLabel.backgroundColor = R.color.placeholder()?.withAlphaComponent(0.5)
        valueLabel.layer.cornerRadius = 10
        valueLabel.layer.masksToBounds = true
        super.customUI()
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.greaterThanOrEqualTo(20)
        }
        cardView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(30)
        }
    }
}
