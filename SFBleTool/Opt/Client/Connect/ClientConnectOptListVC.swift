//
//  ClientConnectOptListVC.swift
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

// MARK: ClientConnectOptListVC
class ClientConnectOptListVC: OptListVC {
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.Main.client_opt_list_connect
    }
    
    // MARK: override
    override func addNew() {
        let vc = ClientConnectOptDetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

