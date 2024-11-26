//
//  CentralManagerStringInfoView.swift
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

// MARK: - OptDetailStringCell
class OptDetailStringCell: OptDetailCell {
    // MARK: ui
    lazy var textField: SFTextField = {
        return SFTextField().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
            view.textColor = SFColor.UI.title
            view.textAlignment = .center
        }
    }()
    override func customUI() {
        super.customUI()
        mainView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: override
    override func update(model: OptItemModel) {
        super.update(model: model)
        guard let value = model.value as? String else { return }
        textField.text = value
    }
}
