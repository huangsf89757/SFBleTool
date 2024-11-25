//
//  ClientConnectOptDetailVC.swift
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

// MARK: ClientConnectOptDetailVC
class ClientConnectOptDetailVC: OptDetailVC {
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = OptModel()
        model.title = SFText.Main.client_opt_detail_connect
        model.desc = SFText.Main.client_opt_detail_connect_desc
        let itemModel_reconnect = OptItemModel(item: .client(.connect(.reconnect)), cellType: .bool)
        let itemModel_bridging = OptItemModel(item: .client(.connect(.bridging)), cellType: .bool)
        let itemModel_connection = OptItemModel(item: .client(.connect(.connection)), cellType: .bool)
        let itemModel_disconnection = OptItemModel(item: .client(.connect(.disconnection)), cellType: .bool)
        let itemModel_notification = OptItemModel(item: .client(.connect(.notification)), cellType: .bool)
        let itemModel_ancs = OptItemModel(item: .client(.connect(.ancs)), cellType: .bool)
        let itemModel_delay = OptItemModel(item: .client(.connect(.delay)), cellType: .string)
        model.itemModels = [itemModel_reconnect, itemModel_bridging, itemModel_connection, itemModel_disconnection, itemModel_notification, itemModel_ancs, itemModel_delay]
        self.model = model
    }
}

