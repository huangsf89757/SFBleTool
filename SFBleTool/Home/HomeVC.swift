//
//  HomeVC.swift
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
// Server
import SFLogger
// Third
import SideMenu

// MARK: - HomeVC
class HomeVC: SFViewController {
    // MARK: var
    
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingBtn)
    }
    
    // MARK: ui
    private lazy var userBtn: SFButton = {
        return SFButton().then { view in
            view.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
            view.setImage(SFImage.User.user, for: .normal)
            view.addTarget(self, action: #selector(userBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var settingBtn: SFButton = {
        return SFButton().then { view in
            view.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
            view.setImage(SFImage.UI.Com.setting, for: .normal)
            view.addTarget(self, action: #selector(settingBtnClicked), for: .touchUpInside)
        }
    }()
    
    // MARK: func
    func settingAction() {

    }
}

// MARK: - action
extension HomeVC {
    /// 点击用户
    @objc private func userBtnClicked() {
        let vc = UserCenterVC()
        let nav = SideMenuNavigationController(rootViewController: vc)
        nav.leftSide = true
        nav.menuWidth = SFApp.screenWidthPortrait() * 0.8
        present(nav, animated: true, completion: nil)
    }
    /// 点击设置
    @objc private func settingBtnClicked() {
        settingAction()
    }
}
