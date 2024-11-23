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
    }
}

