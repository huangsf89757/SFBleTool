//
//  OptItem.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/25.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: - OptItem
enum OptItem {
    case none
    case client(Client)
    case server(Server)
    
    
    enum Client {
        case initial(Initial)
        case scan(Scan)
        case connect(Connect)
        
        enum Initial {
            case identifier
            case alert
        }
        
        enum Scan {
            case duplicates
            case uuids
        }
        
        enum Connect {
            case reconnect
            case bridging
            case connection
            case disconnection
            case notification
            case ancs
            case delay
        }
    }
    
    enum Server {
        
    }
}

// MARK: - code
extension OptItem {
    /// code
    var code: Int {
        switch self {
        case .none:
            return 0
        case .client(let client):
            switch client {
            case .initial(let initial):
                switch initial {
                case .identifier:
                    return 111
                case .alert:
                    return 112
                }
            case .scan(let scan):
                switch scan {
                case .duplicates:
                    return 121
                case .uuids:
                    return 122
                }
            case .connect(let connect):
                switch connect {
                case .reconnect:
                    return 131
                case .bridging:
                    return 132
                case .connection:
                    return 133
                case .disconnection:
                    return 134
                case .notification:
                    return 135
                case .ancs:
                    return 136
                case .delay:
                    return 137
                }
            }
        case .server(let server):
            return 200
        }
    }
    
    init(code: Int) {
        switch code {
        case 111:
            self = .client(.initial(.identifier))
        case 112:
            self = .client(.initial(.alert))
        case 121:
            self = .client(.scan(.duplicates))
        case 122:
            self = .client(.scan(.uuids))
        case 131:
            self = .client(.connect(.reconnect))
        case 132:
            self = .client(.connect(.bridging))
        case 133:
            self = .client(.connect(.connection))
        case 134:
            self = .client(.connect(.disconnection))
        case 135:
            self = .client(.connect(.notification))
        case 136:
            self = .client(.connect(.ancs))
        case 137:
            self = .client(.connect(.delay))
        default:
            self = .none
        }
    }
    
    static func getOptItemCodes(with type: Int) -> [Int] {
        switch type {
        case 110:
            return [111, 112]
        case 120:
            return [121, 122]
        case 130:
            return [131, 132, 133, 134, 135, 136, 137]
        default:
            return []
        }
    }
}

// MARK: - title/desc
extension OptItem {
    /// title
    var title: String {
        switch self {
        case .none:
            return ""
        case .client(let client):
            switch client {
            case .initial(let initial):
                switch initial {
                case .identifier:
                    return SFText.Main.client_opt_detail_initial_identifier
                case .alert:
                    return SFText.Main.client_opt_detail_initial_alert
                }
            case .scan(let scan):
                switch scan {
                case .duplicates:
                    return SFText.Main.client_opt_detail_scan_duplicates
                case .uuids:
                    return SFText.Main.client_opt_detail_scan_uuids
                }
            case .connect(let connect):
                switch connect {
                case .reconnect:
                    return SFText.Main.client_opt_detail_connect_reconnect
                case .bridging:
                    return SFText.Main.client_opt_detail_connect_bridging
                case .connection:
                    return SFText.Main.client_opt_detail_connect_connection
                case .disconnection:
                    return SFText.Main.client_opt_detail_connect_disconnection
                case .notification:
                    return SFText.Main.client_opt_detail_connect_notification
                case .ancs:
                    return SFText.Main.client_opt_detail_connect_ancs
                case .delay:
                    return SFText.Main.client_opt_detail_connect_delay
                }
            }
        case .server(let server):
            return ""
        }
    }
    
    /// desc
    var desc: String {
        switch self {
        case .none:
            return ""
        case .client(let client):
            switch client {
            case .initial(let initial):
                switch initial {
                case .identifier:
                    return SFText.Main.client_opt_detail_initial_identifier_desc
                case .alert:
                    return SFText.Main.client_opt_detail_initial_alert_desc
                }
            case .scan(let scan):
                switch scan {
                case .duplicates:
                    return SFText.Main.client_opt_detail_scan_duplicates_desc
                case .uuids:
                    return SFText.Main.client_opt_detail_scan_uuids_desc
                }
            case .connect(let connect):
                switch connect {
                case .reconnect:
                    return SFText.Main.client_opt_detail_connect_reconnect_desc
                case .bridging:
                    return SFText.Main.client_opt_detail_connect_bridging_desc
                case .connection:
                    return SFText.Main.client_opt_detail_connect_connection_desc
                case .disconnection:
                    return SFText.Main.client_opt_detail_connect_disconnection_desc
                case .notification:
                    return SFText.Main.client_opt_detail_connect_notification_desc
                case .ancs:
                    return SFText.Main.client_opt_detail_connect_ancs_desc
                case .delay:
                    return SFText.Main.client_opt_detail_connect_delay_desc
                }
            }
        case .server(let server):
            return ""
        }
    }
}

// MARK: - valueType
extension OptItem {
    /// value类型
    enum ValueType {
        case none
        case string
        case bool
    }
    var valueType: ValueType {
        switch self {
        case .none:
            return .none
        case .client(let client):
            switch client {
            case .initial(let initial):
                switch initial {
                case .identifier:
                    return .string
                case .alert:
                    return .bool
                }
            case .scan(let scan):
                switch scan {
                case .duplicates:
                    return .bool
                case .uuids:
                    return .string
                }
            case .connect(let connect):
                switch connect {
                case .reconnect:
                    return .bool
                case .bridging:
                    return .bool
                case .connection:
                    return .bool
                case .disconnection:
                    return .bool
                case .notification:
                    return .bool
                case .ancs:
                    return .bool
                case .delay:
                    return .string
                }
            }
        case .server(let server):
            return .bool
        }
    }
}
