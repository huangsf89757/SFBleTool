//
//  SFCopyrightView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/14.
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


// MARK: - SFCopyrightView
class SFCopyrightView: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var versionLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 10, weight: .regular)
            view.textColor = SFColor.UI.subtitle
            view.text = String(format: "Version %@(%@)", SFApp.version, SFApp.build)
            view.textAlignment = .center
        }
    }()
    private lazy var copyrightLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 10, weight: .regular)
            view.textColor = SFColor.UI.subtitle
//            view.text = R.string.localizable.copyright()
            view.textAlignment = .center
        }
    }()
    private func customUI() {
        addSubview(versionLabel)
        addSubview(copyrightLabel)
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        copyrightLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
