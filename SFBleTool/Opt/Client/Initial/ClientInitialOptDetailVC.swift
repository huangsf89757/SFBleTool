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
        let model = OptModel()
        model.title = SFText.Main.client_opt_detail_initial
        model.desc = SFText.Main.client_opt_detail_initial_desc
        let itemModel_identifier = OptItemModel(item: .client(.initial(.identifier)), cellType: .string)
        let itemModel_alert = OptItemModel(item: .client(.initial(.alert)), cellType: .bool)
        model.itemModels = [itemModel_identifier, itemModel_alert]
        self.model = model
    }
}
