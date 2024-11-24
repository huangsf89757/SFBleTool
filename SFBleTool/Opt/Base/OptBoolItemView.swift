//
//  CentralManagerBoolView.swift
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

// MARK: - OptBoolItemView
class OptBoolItemView: OptItemView {
    // MARK: ui
    lazy var switchView: UISwitch = {
        return UISwitch()
    }()
    override func customUI() {
        super.customUI()
        addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
