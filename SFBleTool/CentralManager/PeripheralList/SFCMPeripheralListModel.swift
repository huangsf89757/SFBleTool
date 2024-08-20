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
    var name: String?
    var uuid: UUID?
    var rssi: Double?
    var advData: [String : Any]?
    
    var peripheral: CBPeripheral?
}
