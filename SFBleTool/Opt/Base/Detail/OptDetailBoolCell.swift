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

// MARK: - OptDetailBoolCell
class OptDetailBoolCell: OptDetailCell {
    // MARK: ui
    lazy var switchView: UISwitch = {
        return UISwitch().then { view in
            view.addTarget(self, action: #selector(switchViewAction(_:)), for: .valueChanged)
        }
    }()
    override func customUI() {
        super.customUI()
        mainView.addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: override
    override func update(model: OptItemModel) {
        super.update(model: model)
        guard let value = model.value as? Bool else { return }
        switchView.setOn(value, animated: false)
    }
}

// MARK: - Action
extension OptDetailBoolCell {
    @objc private func switchViewAction(_ sender: UISwitch) {
        model?.value = sender.isOn
    }
}
