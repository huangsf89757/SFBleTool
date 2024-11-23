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
            NSLocalizedString(name, bundle: Self.bundle ?? .main, comment: name)
        }
        
        public static var name: String { text(name: "name") }
        public static var slogen: String { text(name: "slogen") }
    }
}

