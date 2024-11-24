//
//  ClientScanOptDetailVC.swift
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

// MARK: ClientScanOptDetailVC
class ClientScanOptDetailVC: OptDetailVC {
    // MARK: var
    
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.Main.client_opt_detail_scan
        nameView.subtitleLabel.text = SFText.Main.client_opt_detail_scan_desc
    }
    
    // MARK: ui
    lazy var duplicatesView: OptStringItemView = {
        return OptStringItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_scan_duplicates
            view.subtitleLabel.text = SFText.Main.client_opt_detail_scan_duplicates_desc
        }
    }()
    lazy var uuidsView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_scan_uuids
            view.subtitleLabel.text = SFText.Main.client_opt_detail_scan_uuids_desc
        }
    }()
   
    override func customUI() {
        super.customUI()
        scrollView.contentView.addSubview(duplicatesView)
        scrollView.contentView.addSubview(uuidsView)
        
        duplicatesView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        uuidsView.snp.makeConstraints { make in
            make.top.equalTo(duplicatesView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
}
