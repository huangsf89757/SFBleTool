//
//  SFText.swift
//  SFBusiness
//
//  Created by hsf on 2024/11/19.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: - SFText
extension SFText {
    public struct Main {
        public static var bundle = Bundle.main
        private static func text(name: String) -> String {
            NSLocalizedString(name, bundle: Self.bundle, comment: name)
        }
        
        public static var app_name: String { text(name: "app_name") }
        public static var app_slogen: String { text(name: "app_slogen") }
        public static var entrance_client_title: String { text(name: "entrance_client_title") }
        public static var entrance_client_subtitle: String { text(name: "entrance_client_subtitle") }
        public static var entrance_server_title: String { text(name: "entrance_server_title") }
        public static var entrance_server_subtitle: String { text(name: "entrance_server_subtitle") }
        
        public static var central_list: String { text(name: "central_list") }
        public static var peripheral_list: String { text(name: "peripheral_list") }
        
        public static var userCenter_title_opt: String { text(name: "userCenter_title_opt") }
        
        public static var userCenter_item_opt_initial: String { text(name: "userCenter_item_opt_initial") }
        public static var userCenter_item_opt_scan: String { text(name: "userCenter_item_opt_scan") }
        public static var userCenter_item_opt_connect: String { text(name: "userCenter_item_opt_connect") }
        
        public static var peripheral_list_search_hint: String { text(name: "peripheral_list_search_hint") }
        public static var peripheral_list_sort_name: String { text(name: "peripheral_list_sort_name") }
        public static var peripheral_list_sort_rssi: String { text(name: "peripheral_list_sort_rssi") }
        public static var peripheral_list_filter_title: String { text(name: "peripheral_list_filter_title") }
        public static var peripheral_list_filter_uuid: String { text(name: "peripheral_list_filter_uuid") }
        public static var peripheral_list_filter_uuid_hint: String { text(name: "peripheral_list_filter_uuid_hint") }
        public static var peripheral_list_filter_rssi: String { text(name: "peripheral_list_filter_rssi") }
        public static var peripheral_list_filter_reset: String { text(name: "peripheral_list_filter_reset") }
        public static var peripheral_list_filter_sure: String { text(name: "peripheral_list_filter_sure") }
        
        public static var peripheral_list_scan_paused: String { text(name: "peripheral_list_scan_paused") }
        public static var peripheral_list_scan_doing: String { text(name: "peripheral_list_scan_doing") }
    }
}

