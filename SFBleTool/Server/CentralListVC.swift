//
//  CentralListVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// UI
import SFUI
// Server
import SFLogger

// MARK: - CentralListVC
class CentralListVC: SFManagerVC {
    // MARK: var
    
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.entrance_opt_peripheral_title()
    }
}
