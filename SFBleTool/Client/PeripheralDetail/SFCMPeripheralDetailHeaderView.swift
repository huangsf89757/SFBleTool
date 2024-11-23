//
//  SFCMPeripheralDetailHeaderView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/15.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Server
import SFLogger


// MARK: - SFCMPeripheralDetailHeaderView
class SFCMPeripheralDetailHeaderView: SFView {
    // MARK: data
    var model: PeripheralModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.name ?? PeripheralModel.defaultName
            uuidLabel.text = model.uuid?.uuidString
            rssiView.rssi = model.rssi // FIXME
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SFColor.UI.background
        customUI()
    }
    
    // MARK: ui
    private lazy var rssiView: SFRssiView = {
        return SFRssiView()
    }()
    private lazy var nameView: SFView = {
        return SFView()
    }()
    private lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 19, weight: .bold)
            view.textColor = SFColor.UI.title
        }
    }()
    private lazy var uuidLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.subtitle
        }
    }()
    private func customUI() {
        addSubview(rssiView)
        addSubview(nameView)
        nameView.addSubview(nameLabel)
        nameView.addSubview(uuidLabel)
        
        rssiView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        nameView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
            make.leading.equalTo(rssiView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        uuidLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
