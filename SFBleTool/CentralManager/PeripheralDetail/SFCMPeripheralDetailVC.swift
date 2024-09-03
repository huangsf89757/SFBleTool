//
//  SFCMPeripheralDetailVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/14.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// UI
import SFUI
// Server
import SFLogger


// MARK: - SFCMPeripheralDetailVC
class SFCMPeripheralDetailVC: SFViewController {
    // MARK: child vc
    private lazy var advVc: SFCMPeripheralAdvDetailVC = {
        return SFCMPeripheralAdvDetailVC().then { vc in
            vc.view.isHidden = false
            vc.navTitleDidChangedBlock = {
                [weak self] title in
                self?.changeNavTitle(to: title)
            }
        }
    }()
    private lazy var serviceVc: SFCMPeripheralServiceDetailVC = {
        return SFCMPeripheralServiceDetailVC().then { vc in
            vc.view.isHidden = true
            vc.navTitleDidChangedBlock = {
                [weak self] title in
                self?.changeNavTitle(to: title)
            }
        }
    }()
    private lazy var logVc: SFCMPeripheralLogDetailVC = {
        return SFCMPeripheralLogDetailVC().then { vc in
            vc.view.isHidden = true
            vc.navTitleDidChangedBlock = {
                [weak self] title in
                self?.changeNavTitle(to: title)
            }
        }
    }()
    
    
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "AiDEX X-TEST000001"
        customUI()
    }
    
    // MARK: ui
    private lazy var barView: SFCMPeripheralDetailBarView = {
        return SFCMPeripheralDetailBarView().then { view in
            view.didSelectedBlock = {
                [weak self] index in
                self?.advVc.view.isHidden = index != 0
                self?.serviceVc.view.isHidden = index != 1
                self?.logVc.view.isHidden = index != 2
                
                self?.advVc.scrollView.stopScrolling()
                self?.serviceVc.servicesView.tableView.stopScrolling()
                self?.logVc.tableView.stopScrolling()
                
                let titles = [self?.advVc.navTitle, self?.serviceVc.navTitle, self?.logVc.navTitle]
                let title = titles[index]
                self?.changeNavTitle(to: title)
            }
        }
    }()
    private func customUI() {
        view.addSubview(advVc.view)
        view.addSubview(serviceVc.view)
        view.addSubview(logVc.view)
        view.addSubview(barView)
        
        barView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        advVc.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.bottom.equalTo(barView.snp.top).offset(-20)
        }
        serviceVc.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.bottom.equalTo(barView.snp.top).offset(-20)
        }
        logVc.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.bottom.equalTo(barView.snp.top).offset(-20)
        }
    }
    
    // MARK: func
    private func changeNavTitle(to title: String?) {
        if let title = title {
            navigationItem.title = title
        } else {
            navigationItem.title = "AiDEX X-TEST000001"
        }
    }
    
}

