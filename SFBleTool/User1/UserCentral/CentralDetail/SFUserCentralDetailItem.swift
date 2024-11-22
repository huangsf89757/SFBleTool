//
//  SFUserCentralDetailItem.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/16.
//

import Foundation


// MARK: - SFUserCentralDetailItem
enum SFUserCentralDetailItem {
    case showPowerAlert
    case restoreIdentifier
    case allowDuplicates
    case solicitedServiceUUIDs
    case enableAutoReconnect
    case enableTransportBridging
    case notifyOnConnection
    case notifyOnDisconnection
    case notifyOnNotification
    case requiresANCS
    case startDelay
    
    var text: String {
        switch self {
        case .showPowerAlert:
            return R.string.localizable.user_central_detail_init_title_isShowPowerAlert()
        case .restoreIdentifier:
            return R.string.localizable.user_central_detail_init_title_restoreIdentifier()
        case .allowDuplicates:
            return R.string.localizable.user_central_detail_scan_title_isAllowDuplicates()
        case .solicitedServiceUUIDs:
            return R.string.localizable.user_central_detail_scan_title_solicitedServiceUUIDs()
        case .enableAutoReconnect:
            return R.string.localizable.user_central_detail_connect_title_isEnableAutoReconnect()
        case .enableTransportBridging:
            return R.string.localizable.user_central_detail_connect_title_isEnableTransportBridging()
        case .notifyOnConnection:
            return R.string.localizable.user_central_detail_connect_title_isNotifyOnConnection()
        case .notifyOnDisconnection:
            return R.string.localizable.user_central_detail_connect_title_isNotifyOnDisconnection()
        case .notifyOnNotification:
            return R.string.localizable.user_central_detail_connect_title_isNotifyOnNotification()
        case .requiresANCS:
            return R.string.localizable.user_central_detail_connect_title_isRequiresANCS()
        case .startDelay:
            return R.string.localizable.user_central_detail_connect_title_startDelay()
        }
    }
    
    var detail: String {
        switch self {
        case .showPowerAlert:
            return R.string.localizable.user_central_detail_init_subtitle_isShowPowerAlert()
        case .restoreIdentifier:
            return R.string.localizable.user_central_detail_init_subtitle_restoreIdentifier()
        case .allowDuplicates:
            return R.string.localizable.user_central_detail_scan_subtitle_isAllowDuplicates()
        case .solicitedServiceUUIDs:
            return R.string.localizable.user_central_detail_scan_subtitle_solicitedServiceUUIDs()
        case .enableAutoReconnect:
            return R.string.localizable.user_central_detail_connect_subtitle_isEnableAutoReconnect()
        case .enableTransportBridging:
            return R.string.localizable.user_central_detail_connect_subtitle_isEnableTransportBridging()
        case .notifyOnConnection:
            return R.string.localizable.user_central_detail_connect_subtitle_isNotifyOnConnection()
        case .notifyOnDisconnection:
            return R.string.localizable.user_central_detail_connect_subtitle_isNotifyOnDisconnection()
        case .notifyOnNotification:
            return R.string.localizable.user_central_detail_connect_subtitle_isNotifyOnNotification()
        case .requiresANCS:
            return R.string.localizable.user_central_detail_connect_subtitle_isRequiresANCS()
        case .startDelay:
            return R.string.localizable.user_central_detail_connect_subtitle_startDelay()
        }
    }
    
    var key: String {
        switch self {
        case .showPowerAlert:
            return R.string.localizable.user_central_detail_init_key_isShowPowerAlert()
        case .restoreIdentifier:
            return R.string.localizable.user_central_detail_init_key_restoreIdentifier()
        case .allowDuplicates:
            return R.string.localizable.user_central_detail_scan_key_isAllowDuplicates()
        case .solicitedServiceUUIDs:
            return R.string.localizable.user_central_detail_scan_key_solicitedServiceUUIDs()
        case .enableAutoReconnect:
            return R.string.localizable.user_central_detail_connect_key_isEnableAutoReconnect()
        case .enableTransportBridging:
            return R.string.localizable.user_central_detail_connect_key_isEnableTransportBridging()
        case .notifyOnConnection:
            return R.string.localizable.user_central_detail_connect_key_isNotifyOnConnection()
        case .notifyOnDisconnection:
            return R.string.localizable.user_central_detail_connect_key_isNotifyOnDisconnection()
        case .notifyOnNotification:
            return R.string.localizable.user_central_detail_connect_key_isNotifyOnNotification()
        case .requiresANCS:
            return R.string.localizable.user_central_detail_connect_key_isRequiresANCS()
        case .startDelay:
            return R.string.localizable.user_central_detail_connect_key_startDelay()
        }
    }
    
}
