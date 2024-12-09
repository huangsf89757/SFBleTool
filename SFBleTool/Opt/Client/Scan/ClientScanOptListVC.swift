//
//  ClientScanOptListVC.swift
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

// MARK: ClientScanOptListVC
class ClientScanOptListVC: OptListVC {
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.Main.client_opt_list_scan
    }
    
    // MARK: override
    override func addNew() {
        let vc = ClientScanOptDetailVC()
        let optModel = OptModel()
        optModel.default_clientScan()
        vc.model = optModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

