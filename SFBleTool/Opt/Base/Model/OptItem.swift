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
    
    /// title
    var title: String {
        switch self {
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
