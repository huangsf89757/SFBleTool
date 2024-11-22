//
//  PeripheralScanningOptionDetailVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// UI
import SFUI

// MARK: PeripheralScanningOptionDetailVC
class PeripheralScanningOptionDetailVC: OptionDetailVC {
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
                                      Peripheral Scanning Options
                                      Keys used to pass options when scanning for peripherals.
                                      """
    }
    
    // MARK: ui
    lazy var duplicatesView: OptionStringItemView = {
        return OptionStringItemView().then { view in
            view.titleLabel.text = "AllowDuplicates"
            view.subtitleLabel.text = """
                                      CBCentralManagerScanOptionAllowDuplicatesKey
                                      A Boolean value that specifies whether the scan should run without duplicate filtering.
                                      """
        }
    }()
    lazy var uuidsView: OptionBoolItemView = {
        return OptionBoolItemView().then { view in
            view.titleLabel.text = "SolicitedServiceUUIDs"
            view.subtitleLabel.text = """
                                      CBCentralManagerScanOptionSolicitedServiceUUIDsKey
                                      An array of service UUIDs that you want to scan for.
                                      """
        }
    }()
   
    override func customUI() {
        super.customUI()
        scrollView.contentView.addSubview(duplicatesView)
        scrollView.contentView.addSubview(uuidsView)
        
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
