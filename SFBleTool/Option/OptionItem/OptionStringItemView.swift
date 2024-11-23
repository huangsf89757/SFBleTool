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

// MARK: - OptionStringItemView
class OptionStringItemView: OptionItemView {
    
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
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

