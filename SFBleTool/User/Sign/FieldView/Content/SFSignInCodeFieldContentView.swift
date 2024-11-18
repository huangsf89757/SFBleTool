//
//  SFSignInCodeFieldContentView.swift
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

// MARK: - SFSignInCodeFieldContentView
class SFSignInCodeFieldContentView: SFSignFieldContentView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var accountFieldView: SFSignAccountFieldView = {
        return SFSignAccountFieldView()
    }()
    private lazy var codeFieldView: SFSignCodeFieldView = {
        return SFSignCodeFieldView()
    }()
    private lazy var dividerView: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.divider()
        }
    }()
    
    private func customUI() {
        addSubview(accountFieldView)
        addSubview(dividerView)
        addSubview(codeFieldView)
        
        accountFieldView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(accountFieldView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        codeFieldView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
