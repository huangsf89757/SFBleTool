//
//  OptType.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/28.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: - OptType
enum OptType {
    case none
    case client(Client)
    case server(Server)
    
    
    enum Client {
        case initial
        case scan
        case connect
    }
    
    enum Server {
        
    }
}

// MARK: - Equatable
extension OptType: Equatable {
    static func == (lhs: OptType, rhs: OptType) -> Bool {
        lhs.code == rhs.code
    }
}

// MARK: - item
extension OptType {
    var items: [OptItem] {
        switch self {
        case .none:
            return []
        case .client(let client):
            switch client {
            case .initial:
                return [
                    .client(.initial(.identifier)),
                    .client(.initial(.alert)),
                ]
            case .scan:
                return [
                    .client(.scan(.duplicates)),
                    .client(.scan(.uuids)),
                ]
            case .connect:
                return [
                    .client(.connect(.reconnect)),
                    .client(.connect(.bridging)),
                    .client(.connect(.connection)),
                    .client(.connect(.disconnection)),
                    .client(.connect(.notification)),
                    .client(.connect(.ancs)),
                    .client(.connect(.delay)),
                ]
            }
        case .server(let server):
            return []
        }
    }
}

// MARK: - code
extension OptType {
    /// code
    var code: Int {
        switch self {
        case .none:
            return 0
        case .client(let client):
            switch client {
            case .initial:
                return 110
            case .scan:
                return 120
            case .connect:
                return 130
            }
        case .server(let server):
            return 200
        }
    }
    
    static var codes: [Int] = [110, 120, 130, 200]
    
    init?(code: Int) {
        switch code {
        case 110:
            self = .client(.initial)
        case 120:
            self = .client(.scan)
        case 130:
            self = .client(.connect)
        default:
            return nil
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
extension OptType {
    /// list
    var list: String {
        switch self {
        case .none:
            return ""
        case .client(let client):
            switch client {
            case .initial:
                return SFText.Main.client_opt_list_initial
            case .scan:
                return SFText.Main.client_opt_list_scan
            case .connect:
                return SFText.Main.client_opt_list_connect
            }
        case .server(let server):
            return ""
        }
    }
    
    /// title
    var title: String {
        switch self {
        case .none:
            return ""
        case .client(let client):
            switch client {
            case .initial:
                return SFText.Main.client_opt_detail_initial
            case .scan:
                return SFText.Main.client_opt_detail_scan
            case .connect:
                return SFText.Main.client_opt_detail_connect
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
            case .initial:
                return SFText.Main.client_opt_detail_initial_desc
            case .scan:
                return SFText.Main.client_opt_detail_scan_desc
            case .connect:
                return SFText.Main.client_opt_detail_connect_desc
            }
        case .server(let server):
            return ""
        }
    }
}
