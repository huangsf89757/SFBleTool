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
import Macaw

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
        let svg = SVGView()
//        svg.node = 
        
    
//        // 获取私有库的 Bundle
//        let privateLibraryBundle = Bundle.module
//
//        // 加载 SVG 文件数据
//        if let svgURL = privateLibraryBundle.url(forResource: "myIcon", withExtension: "svg"),
//           let svgData = try? Data(contentsOf: svgURL),
//           let svgNode = try? SVGParser.parse(data: svgData) {
//            let macawView = MacawView(node: svgNode, frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//            view.addSubview(macawView)
//        } else {
//            print("无法加载 myIcon.svg 文件的数据")
//        }
//        
//        // 获取私有库的 Bundle
//        let privateLibraryBundle = Bundle.module // Swift Package Manager 提供的默认方法
//
//        // 加载 SVG 文件路径
//        if let svgPath = privateLibraryBundle.path(forResource: "myIcon", ofType: "svg") {
//            let svgView = try! SVGParser.parse(path: svgPath)
//            let macawView = MacawView(node: svgView, frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//            view.addSubview(macawView)
//        } else {
//            print("无法找到 myIcon.svg 文件")
//        }

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
