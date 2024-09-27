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
    lazy var valueLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = R.color.subtitle()
            view.numberOfLines = 0
            view.textAlignment = .center
            view.backgroundColor = R.color.placeholder()?.withAlphaComponent(0.5)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    override func customUI() {
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
