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
        
        struct Com {
            public static var goto: UIImage? { image(name: "com/goto") }
            struct Select {
                public static var nor: UIImage? { image(name: "com/select/nor") }
                public static var sel: UIImage? { image(name: "com/select/sel") }
            }
        }
    }
}

