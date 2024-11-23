//
//  SFImage.swift
//  SFBusiness
//
//  Created by hsf on 2024/7/23.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: - SFImage
extension SFImage {
    public struct Main {
        public static var bundle = Bundle.main
        private static func image(name: String) -> UIImage? {
            UIImage.sf.image(name: name, bundle: Self.bundle)
        }
        
        public static var icon: UIImage? { image(name: "AppIcon") }
        public static var logo: UIImage? { image(name: "AppLogo") }
        
        public struct Com {
            public static var goto: UIImage? { image(name: "com/goto") }
            struct Select {
                public static var nor: UIImage? { image(name: "com/select/nor") }
                public static var sel: UIImage? { image(name: "com/select/sel") }
            }
        }
        
        public struct User {
            public struct Center {
                public struct Opt {
                    public static var initial: UIImage? { image(name: "user/center/opt/initial") }
                    public static var scan: UIImage? { image(name: "user/center/opt/scan") }
                    public static var connect: UIImage? { image(name: "user/center/opt/connect") }
                }
            }
        }
        
        public struct Ble {
            struct Scan {
                public static var nor: UIImage? { image(name: "ble/scan/nor") }
                public static var sel: UIImage? { image(name: "ble/scan/sel") }
            }
        }
    }
}

