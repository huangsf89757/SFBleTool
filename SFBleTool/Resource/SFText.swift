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
        
        
        public static var client_opt: String { text(name: "client_opt") }
        public static var server_opt: String { text(name: "server_opt") }
        
        public static var opt_list_new: String { text(name: "opt_list_new") }
        public static var opt_list_using: String { text(name: "opt_list_using") }
        public static var opt_list_save_msg: String { text(name: "opt_list_save_msg") }
        
        public static var opt_config: String { text(name: "opt_config") }
        public static var opt_config_save_msg: String { text(name: "opt_config_save_msg") }
        
        public static var opt_detail: String { text(name: "opt_detail") }
        public static var opt_detail_save_msg: String { text(name: "opt_detail_save_msg") }
        
        public static var opt_detail_hint_name: String { text(name: "opt_detail_hint_name") }
        
        public static var opt_detail_name: String { text(name: "opt_detail_name") }
        public static var opt_detail_name_desc: String { text(name: "opt_detail_name_desc") }
        
        public static var client_opt_list_initial: String { text(name: "client_opt_list_initial") }
        public static var client_opt_list_scan: String { text(name: "client_opt_list_scan") }
        public static var client_opt_list_connect: String { text(name: "client_opt_list_connect") }
        
        public static var client_opt_detail_initial: String { text(name: "client_opt_detail_initial") }
        public static var client_opt_detail_initial_desc: String { text(name: "client_opt_detail_initial_desc") }
        public static var client_opt_detail_initial_identifier: String { text(name: "client_opt_detail_initial_identifier") }
        public static var client_opt_detail_initial_identifier_desc: String { text(name: "client_opt_detail_initial_identifier_desc") }
        public static var client_opt_detail_initial_alert: String { text(name: "client_opt_detail_initial_alert") }
        public static var client_opt_detail_initial_alert_desc: String { text(name: "client_opt_detail_initial_alert_desc") }
        
        public static var client_opt_detail_scan: String { text(name: "client_opt_detail_scan") }
        public static var client_opt_detail_scan_desc: String { text(name: "client_opt_detail_scan_desc") }
        public static var client_opt_detail_scan_duplicates: String { text(name: "client_opt_detail_scan_duplicates") }
        public static var client_opt_detail_scan_duplicates_desc: String { text(name: "client_opt_detail_scan_duplicates_desc") }
        public static var client_opt_detail_scan_uuids: String { text(name: "client_opt_detail_scan_uuids") }
        public static var client_opt_detail_scan_uuids_desc: String { text(name: "client_opt_detail_scan_uuids_desc") }
        
        public static var client_opt_detail_connect: String { text(name: "client_opt_detail_connect") }
        public static var client_opt_detail_connect_desc: String { text(name: "client_opt_detail_connect_desc") }
        public static var client_opt_detail_connect_ancs: String { text(name: "client_opt_detail_connect_ancs") }
        public static var client_opt_detail_connect_ancs_desc: String { text(name: "client_opt_detail_connect_ancs_desc") }
        public static var client_opt_detail_connect_bridging: String { text(name: "client_opt_detail_connect_bridging") }
        public static var client_opt_detail_connect_bridging_desc: String { text(name: "client_opt_detail_connect_bridging_desc") }
        public static var client_opt_detail_connect_connection: String { text(name: "client_opt_detail_connect_connection") }
        public static var client_opt_detail_connect_connection_desc: String { text(name: "client_opt_detail_connect_connection_desc") }
        public static var client_opt_detail_connect_delay: String { text(name: "client_opt_detail_connect_delay") }
        public static var client_opt_detail_connect_delay_desc: String { text(name: "client_opt_detail_connect_delay_desc") }
        public static var client_opt_detail_connect_reconnect: String { text(name: "client_opt_detail_connect_reconnect") }
        public static var client_opt_detail_connect_reconnect_desc: String { text(name: "client_opt_detail_connect_reconnect_desc") }
        public static var client_opt_detail_connect_disconnection: String { text(name: "client_opt_detail_connect_disconnection") }
        public static var client_opt_detail_connect_disconnection_desc: String { text(name: "client_opt_detail_connect_disconnection_desc") }
        public static var client_opt_detail_connect_notification: String { text(name: "client_opt_detail_connect_notification") }
        public static var client_opt_detail_connect_notification_desc: String { text(name: "client_opt_detail_connect_notification_desc") }
        
    }
}

