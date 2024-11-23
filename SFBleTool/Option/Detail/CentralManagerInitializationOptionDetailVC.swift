//
//  CentralManagerInitializationOptionDetailVC.swift
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

// MARK: CentralManagerInitializationOptionDetailVC
class CentralManagerInitializationOptionDetailVC: OptionDetailVC {
    // MARK: var
    var model: CentralManagerInitializationOptionModel? {
        didSet {
            identifierView.textField.text = model?.identifier
            alertView.switchView.setOn(model?.alert ?? false, animated: false)
        }
    }
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.subtitleLabel.text = """
                                      Central Manager Initialization Options
                                      Keys used to pass options when initializing a central manager.
                                      """
    }
    
    // MARK: ui
    lazy var identifierView: OptionStringItemView = {
        return OptionStringItemView().then { view in
            view.titleLabel.text = "RestoreIdentifier"
            view.subtitleLabel.text = """
                                      CBCentralManagerOptionRestoreIdentifierKey
                                      A string containing a unique identifier (UID) for the central manager to instantiate.
                                      """
        }
    }()
    lazy var alertView: OptionBoolItemView = {
        return OptionBoolItemView().then { view in
            view.titleLabel.text = "ShowPowerAlert"
            view.subtitleLabel.text = """
                                      CBCentralManagerOptionShowPowerAlertKey
                                      A Boolean value that specifies whether the system warns the user if the app instantiates the central manager when Bluetooth service isn’t available.
                                      """
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
}
