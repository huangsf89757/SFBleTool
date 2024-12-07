//
//  AppDelegate.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
//

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

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 环境配置
        SFEnvironment.cur = .dev
        
        // 日志
        SFLogger.config()
        
        // 键盘 TODO: 考虑一下是否使用notify监听didFinishLaunching 实现自动配置
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        // Resource
        SFImage.App.icon = SFImage.Main.icon
        SFImage.App.logo = SFImage.Main.logo
        SFText.App.name = SFText.Main.app_name
        SFText.App.slogen = SFText.Main.app_slogen
        
        // Database
        createClientAppTables()
        buildInData() // 内建数据
        let user = getActiveUser()
        UserModel.active = user
        if let user = UserModel.active {
            createClientUserTables()
        }
        
        // DataService
        SFDataService.shared.provider = DbDataProvider()
         
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

