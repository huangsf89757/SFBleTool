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
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headerTitle = SFText.Main.client_opt_detail_scan
        headerDesc = SFText.Main.client_opt_detail_scan_desc
    }
}
