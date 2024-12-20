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
        guard let value = model.value, let int = Int(value) else { return }
        switchView.setOn(int > 0, animated: false)
    }
    override func isEditDidChanged() {
        super.isEditDidChanged()
        switchView.isUserInteractionEnabled = isEdit
    }
    override func updateIsSelected() {
        super.updateIsSelected()
        if model?.isSelected == true {
            if model?.value == nil {
                model?.value = switchView.isOn ? "1" : "0"
            }
        } else {
            model?.value = nil
        }
    }
}

// MARK: - Action
extension OptDetailBoolCell {
    @objc private func switchViewAction(_ sender: UISwitch) {
        model?.value = sender.isOn ? "1" : "0"
    }
}
