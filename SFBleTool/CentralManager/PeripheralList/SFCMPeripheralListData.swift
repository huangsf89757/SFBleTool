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
        // 过滤
        showModels = discoveredModels.filter { model in
            // search
            if let keyword = headerModel.search.keyword {
                let name = model.name ?? SFCMPeripheralListModel.defaultName
                if name.sf.like("%\(keyword)%") {
                    return true
                } else {
                    return false
                }
            }
            // filter
            
            
            return true
        }
        // 排序
        
        tableView.reloadData()
    }
}
