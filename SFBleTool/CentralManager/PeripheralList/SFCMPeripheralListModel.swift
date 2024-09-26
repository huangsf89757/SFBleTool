//
//  SFCMPeripheralListModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/20.
//

import Foundation
import CoreBluetooth

class SFCMPeripheralListModel {
    // MARK: var
    static let defaultName = "N/A"
    var name: String?
    var uuid: UUID?
    var rssi: Double?
    var advertisementData: [String : Any]?
    
    var peripheral: CBPeripheral?
}
