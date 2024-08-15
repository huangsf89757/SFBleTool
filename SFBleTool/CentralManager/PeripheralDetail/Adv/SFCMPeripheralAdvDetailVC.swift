//
//  SFCMPeripheralAdvDetailVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/14.
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


// MARK: - SFCMPeripheralAdvDetailVC
class SFCMPeripheralAdvDetailVC: SFScrollViewController {
    // MARK: var
    var localNameModel = SFCMPeripheralAdvItemModel(icon: <#T##UIImage#>, title: <#T##String#>, subtitle: <#T##String#>, key: <#T##String#>, value: <#T##String?#>)
    var manufacturerModel = SFCMPeripheralAdvItemModel(icon: <#T##UIImage#>, title: <#T##String#>, subtitle: <#T##String#>, key: <#T##String#>, value: <#T##String?#>)
    var specificServiceModel = SFCMPeripheralAdvItemModel(icon: <#T##UIImage#>, title: <#T##String#>, subtitle: <#T##String#>, key: <#T##String#>, value: <#T##String?#>)
    var serviceUuidModel = SFCMPeripheralAdvItemModel(icon: <#T##UIImage#>, title: <#T##String#>, subtitle: <#T##String#>, key: <#T##String#>, value: <#T##String?#>)
    var overflowUuidModel = SFCMPeripheralAdvItemModel(icon: <#T##UIImage#>, title: <#T##String#>, subtitle: <#T##String#>, key: <#T##String#>, value: <#T##String?#>)
    var txPowerModel = SFCMPeripheralAdvItemModel(icon: <#T##UIImage#>, title: <#T##String#>, subtitle: <#T##String#>, key: <#T##String#>, value: <#T##String?#>)
    var connectableModel = SFCMPeripheralAdvItemModel(icon: <#T##UIImage#>, title: <#T##String#>, subtitle: <#T##String#>, key: <#T##String#>, value: <#T##String?#>)
    var solicitedUuidModel = SFCMPeripheralAdvItemModel(icon: <#T##UIImage#>, title: <#T##String#>, subtitle: <#T##String#>, key: <#T##String#>, value: <#T##String?#>)
    
    var models: [SFCMPeripheralAdvItemModel] {
        return [localNameModel, manufacturerModel, specificServiceModel, serviceUuidModel, overflowUuidModel, txPowerModel, connectableModel, solicitedUuidModel]
    }
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        for model in models {
            let itemView = SFCMPeripheralAdvItemView().then { view in
                
            }
        }
    }
}
