//
//  SFSignInCodeContentView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/11.
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


// MARK: - SFSignInCodeContentView
class SFSignInCodeContentView: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var fieldView: SFSignInCodeFieldContentView = {
        return SFSignInCodeFieldContentView()
    }()
    private lazy var tipLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = R.color.subtitle()
            view.text = R.string.localizable.user_signIn_tip_code()
        }
    }()    
    
    private func customUI() {
        addSubview(fieldView)
        addSubview(tipLabel)
        
        fieldView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(fieldView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(5)
            make.trailing.lessThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
