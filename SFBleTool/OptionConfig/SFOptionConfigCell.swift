//
//  SFOptionConfigCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/21.
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


// MARK: - SFOptionConfigCell
class SFOptionConfigCell: SFTableViewCell {
    // MARK: var
    
    // MARK: data
    var model: PeripheralModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.name
            uuidLabel.text = model.uuid?.uuidString
//            rssiView.rssi = model.rssi // FIXME
        }
    }
    
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = SFColor.UI.background
        contentView.backgroundColor = SFColor.UI.background
        customUI()
        separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
    // MARK: ui
    private lazy var rssiView: SFRssiView = {
        return SFRssiView().then { view in
            
        }
    }()
    private lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 19, weight: .bold)
            view.textColor = SFColor.UI.title
        }
    }()
    private lazy var uuidLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .regular)
            view.textColor = SFColor.UI.subtitle
        }
    }()
    private func customUI() {
        contentView.addSubview(rssiView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(uuidLabel)
        
        rssiView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(60)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(rssiView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        uuidLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(nameLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
    }
}
