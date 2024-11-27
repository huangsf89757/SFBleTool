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
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headerTitle = SFText.Main.client_opt_detail_initial
        headerDesc = SFText.Main.client_opt_detail_initial_desc
    }
}
