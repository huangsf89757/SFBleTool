//
//  SFCMPeripheralListData.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/6.
//

import Foundation
import UIKit
import CoreBluetooth
// Basic
import SFBase
import SFExtension
// UI
import SFUI
// Server
import SFLogger
import SFBluetooth
// Third
import SideMenu

extension SFCMPeripheralListVC {
    func reloadList() {
        showModels = discoveredModels.filter { model in
            if let keyword = headerModel.search.keyword {
                let name = model.name ?? SFCMPeripheralListModel.defaultName
                if name.sf.like(keyword) {
                    return true
                }
            }
            return true
        }
        tableView.reloadData()
    }
}
