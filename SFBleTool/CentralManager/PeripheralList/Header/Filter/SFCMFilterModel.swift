//
//  SFCMFilterModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/20.
//

import Foundation
import CoreBluetooth

class SFCMFilterModel {
    // MARK: var
    var uuids: [CBUUID]?
    var rssi: (Double, Double) = (-90, -50)
}
