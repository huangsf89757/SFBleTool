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
        return SFCMPeripheralAdvDetailVC()
    }()
    private lazy var serviceVc: SFCMPeripheralServiceDetailVC = {
        return SFCMPeripheralServiceDetailVC()
    }()
    private lazy var logVc: SFCMPeripheralLogDetailVC = {
        return SFCMPeripheralLogDetailVC()
    }()
    
    private lazy var barView: SFCMPeripheralDetailBarView = {
        return SFCMPeripheralDetailBarView().then { view in
            view.didSelectedBlock = {
                [weak self] index, title in
                self?.navigationItem.title = title
            }
        }
    }()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.central_bar_adv()
        customLayoutOfDetailVC()
    }
    
    // MARK: ui
    private func customLayoutOfDetailVC() {
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
            make.bottom.equalTo(barView.snp.top).offset(-20)
        }
        serviceVc.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(barView.snp.top).offset(-20)
        }
        logVc.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(barView.snp.top).offset(-20)
        }
    }
    
}

