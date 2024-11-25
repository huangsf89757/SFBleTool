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
        let model = OptModel()
        model.title = SFText.Main.client_opt_detail_scan
        model.desc = SFText.Main.client_opt_detail_scan_desc
        let itemModel_duplicates = OptItemModel(item: .client(.scan(.duplicates)), cellType: .bool)
        let itemModel_uuids = OptItemModel(item: .client(.scan(.uuids)), cellType: .string)
        model.itemModels = [itemModel_duplicates, itemModel_uuids]
        self.model = model
    }
}
