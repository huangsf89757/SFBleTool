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

// MARK: rootPage
extension SceneDelegate {
    func setRootPage() {
        if let user = UserModel.active as? BTUserModel {
            switch user.pageEnum {
            case .entrance:
                let vc = SFEntranceVC()
                vc.willEnterBlock = { page in
                    user.page = page
                    let isSuccess = user.update()
                    return isSuccess
                }
                vc.didEnterBlock = { [weak self] page in
                    self?.setRootPage()
                }
                window?.rootViewController = vc
            case .client:
                window?.rootViewController = SFNavigationController(rootViewController: PeripheralListVC())
            case .server:
                window?.rootViewController = SFNavigationController(rootViewController: CentralListVC())
            }
        } else {
            window?.rootViewController = SFNavigationController(rootViewController: SFUser.SignVC())
        }
    }
}
