//
//  SFCMPeripheralAdvDetailItem.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/15.
//

import Foundation
import UIKit


// MARK: - SFCMPeripheralAdvDetailItem
enum SFCMPeripheralAdvDetailItem {
    case localName
    case manufacturer
    case specificService
    case serviceUuid
    case overflowUuid
    case txPower
    case connectable
    case solicitedUuid
    
    var text: String {
        switch self {
        case .localName:
            return R.string.localizable.central_adv_title_localName()
        case .manufacturer:
            return R.string.localizable.central_adv_title_manufacturer()
        case .specificService:
            return R.string.localizable.central_adv_title_specificService()
        case .serviceUuid:
            return R.string.localizable.central_adv_title_serviceUuid()
        case .overflowUuid:
            return R.string.localizable.central_adv_title_overflowUuid()
        case .txPower:
            return R.string.localizable.central_adv_title_txPower()
        case .connectable:
            return R.string.localizable.central_adv_title_connectable()
        case .solicitedUuid:
            return R.string.localizable.central_adv_title_solicitedUuid()
        }
    }
    
    var detail: String {
        switch self {
        case .localName:
            return R.string.localizable.central_adv_subtitle_localName()
        case .manufacturer:
            return R.string.localizable.central_adv_subtitle_manufacturer()
        case .specificService:
            return R.string.localizable.central_adv_subtitle_specificService()
        case .serviceUuid:
            return R.string.localizable.central_adv_subtitle_serviceUuid()
        case .overflowUuid:
            return R.string.localizable.central_adv_subtitle_overflowUuid()
        case .txPower:
            return R.string.localizable.central_adv_subtitle_txPower()
        case .connectable:
            return R.string.localizable.central_adv_subtitle_connectable()
        case .solicitedUuid:
            return R.string.localizable.central_adv_subtitle_solicitedUuid()
        }
    }
    
    var key: String {
        switch self {
        case .localName:
            return R.string.localizable.central_adv_key_localName()
        case .manufacturer:
            return R.string.localizable.central_adv_key_manufacturer()
        case .specificService:
            return R.string.localizable.central_adv_key_specificService()
        case .serviceUuid:
            return R.string.localizable.central_adv_key_serviceUuid()
        case .overflowUuid:
            return R.string.localizable.central_adv_key_overflowUuid()
        case .txPower:
            return R.string.localizable.central_adv_key_txPower()
        case .connectable:
            return R.string.localizable.central_adv_key_connectable()
        case .solicitedUuid:
            return R.string.localizable.central_adv_key_solicitedUuid()
        }
    }
    
    var image: UIImage? {
        switch self {
        case .localName:
            return R.image.adv.localName()
        case .manufacturer:
            return R.image.adv.manufacturer()
        case .specificService:
            return R.image.adv.service()
        case .serviceUuid:
            return R.image.adv.uuid()
        case .overflowUuid:
            return R.image.adv.uuid()
        case .txPower:
            return R.image.adv.txPower()
        case .connectable:
            return R.image.adv.connectable()
        case .solicitedUuid:
            return R.image.adv.uuid()
        }
    }
}
