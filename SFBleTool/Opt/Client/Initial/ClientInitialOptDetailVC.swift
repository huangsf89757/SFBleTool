//
//  ClientInitialOptDetailVC.swift
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

// MARK: ClientInitialOptDetailVC
class ClientInitialOptDetailVC: OptDetailVC {
    // MARK: var
    var model: ClientInitialOptModel? {
        didSet {
            identifierView.textField.text = model?.identifier
            alertView.switchView.setOn(model?.alert ?? false, animated: false)
        }
    }
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.Main.client_opt_detail_initial
        nameView.subtitleLabel.text = SFText.Main.client_opt_detail_initial_desc
    }
    
    // MARK: ui
    lazy var identifierView: OptStringItemView = {
        return OptStringItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_initial_identifier
            view.subtitleLabel.text = SFText.Main.client_opt_detail_initial_identifier_desc
        }
    }()
    lazy var alertView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_initial_alert
            view.subtitleLabel.text = SFText.Main.client_opt_detail_initial_alert_desc
        }
    }()
   
    override func customUI() {
        super.customUI()
        scrollView.contentView.addSubview(identifierView)
        scrollView.contentView.addSubview(alertView)
        
        identifierView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        alertView.snp.makeConstraints { make in
            make.top.equalTo(identifierView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
    // MARK: override
    override func editOrSave(_ editEnable: Bool) {
        super.editOrSave(editEnable)
        identifierView.editEnable = editEnable
        alertView.editEnable = editEnable
    }
}
