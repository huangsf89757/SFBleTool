//
//  Root.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/23.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Business
import SFBusiness
import SFUser

// MARK: root
enum RootPage: Int {
    case sign = 0
    case entrance
    case client
    case server
}
extension SceneDelegate {
    func setRoot() {
//        if let rootValue = UserDefaults.standard.object(forKey: UserDefaultKey.root) as? Int {
//            root = RootPage(rawValue: rootValue) ?? .sign
//        } else {
//            UserDefaults.standard.setValue(RootPage.sign.rawValue, forKey: UserDefaultKey.root)
//        }
        showPage(root: .client)
    }
    private func showPage(root: RootPage) {
        switch root {
        case .sign:
            window?.rootViewController = SFNavigationController(rootViewController: SFUser.SignVC())
        case .entrance:
            let vc = SFEntranceVC()
            vc.didChooseEntranceOptBlock = {
                [weak self] entrance in
                UserDefaults.standard.setValue(entrance, forKey: UserDefaultKey.root)
                let newRoot = RootPage(rawValue: entrance) ?? .sign
                self?.root = newRoot
                self?.showPage(root: newRoot)
            }
            window?.rootViewController = vc
        case .client:
            window?.rootViewController = SFNavigationController(rootViewController: PeripheralListVC())
        case .server:
            window?.rootViewController = SFNavigationController(rootViewController: CentralListVC())
        }
    }
}
