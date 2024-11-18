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
        let search = headerModel.search
        let searchModels = discoveredModels.filter { model in
            if let keyword = search.keyword {
                let name = model.name ?? SFCMPeripheralListModel.defaultName
                if name.sf.like("%\(keyword)%") {
                    return true
                } else {
                    return false
                }
            }
            return true
        }
        
        // 排序
        let sort = headerModel.sort
        let sortModels = searchModels.sorted { model1, model2 in
            switch sort.medthod {
            case .none:
                return false
            case .name:
                let name1 = model1.name ?? SFCMPeripheralListModel.defaultName
                let name2 = model2.name ?? SFCMPeripheralListModel.defaultName
                switch sort.sort {
                case .none:
                    return false
                case .asc:
                    return name1 < name2
                case .des:
                    return name1 > name2
                }
            case .rssi:
                guard let rssi1 = model1.rssi, let rssi2 = model2.rssi else { return false }
                switch sort.sort {
                case .none:
                    return false
                case .asc:
                    return rssi1 < rssi2
                case .des:
                    return rssi1 > rssi2
                }
            }
        }
        
        // 刷新
        showModels = sortModels
        tableView.reloadData()
    }
}
