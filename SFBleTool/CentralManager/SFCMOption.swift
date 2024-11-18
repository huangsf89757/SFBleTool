//
//  SFCMOption.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/16.
//

import Foundation

enum SFCMInitializationOption {
    case showPowerAlert
    case restoreIdentifier
}

enum SFCMScanningOption {
    case allowDuplicates
    case solicitedServiceUUIDs
}

enum SFCMCConnectionOption {
    case enableAutoReconnect
    case enableTransportBridging
    case notifyOnConnection
    case notifyOnDisconnection
    case notifyOnNotification
    case requiresANCS
    case startDelay
}

enum SFCMStateRestorationOption {
    case peripherals
    case scanServices
    case scanOptions
}
