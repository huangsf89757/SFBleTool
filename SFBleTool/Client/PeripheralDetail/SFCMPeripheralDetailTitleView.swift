//
//  SFCMPeripheralDetailTitleView.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/16.
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


// MARK: - SFCMPeripheralDetailTitleView
class SFCMPeripheralDetailTitleView: SFView {
    // MARK: var
    let titleHeight: CGFloat = 80
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var indicatorView: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.theme
            view.layer.cornerRadius = 2
            view.layer.masksToBounds = true
        }
    }()
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 30, weight: .bold)
            view.textColor = SFColor.UI.title
        }
    }()
    private func customUI() {
        addSubview(indicatorView)
        addSubview(titleLabel)
        indicatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(CGSize(width: 4, height: 20))
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalTo(indicatorView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
    }
}
