//
//  LaunchConfig.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/11.
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
// Server
import SFLogger
// Third
import IQKeyboardManagerSwift


// MARK: - 私有库
extension AppDelegate {
    func config_privatePod_SFLogger() {
        SFLogger.shared.config()
    }
}


// MARK: - 三方库
extension AppDelegate {
    func config_thirdPod_IQKeyboardManagerSwift() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableDebugging = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarManageBehaviour = .byTag
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(CodeContentView.self)
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(PwdContentView.self)
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}


// MARK: - 其他
extension AppDelegate {
    func config_resource() {
        SFImage.App.icon = SFImage.Main.icon
        SFImage.App.logo = SFImage.Main.logo
        SFText.App.name = SFText.Main.app_name
        SFText.App.slogen = SFText.Main.app_slogen
    }
    
    func config_database() {
        SFServerDatabase.createAppTables()
        SFClientDatabase.createAppTables()
        SFDatabase.buildInData()
        let user = SFClientDatabase.getActiveUser()
        UserModel.active = user
        SFClientDatabase.createUserTables()
    }
    
    func config_dataProvider() {
        SFDataService.shared.provider = DbDataProvider()
    }
}
