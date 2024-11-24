//
//  ClientInitialOptListVC.swift
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

// MARK: ClientInitialOptListVC
class ClientInitialOptListVC: OptListVC {
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.Main.client_opt_list_initial
    }
    
    // MARK: override
    override func addNew() {
        let vc = ClientInitialOptDetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
