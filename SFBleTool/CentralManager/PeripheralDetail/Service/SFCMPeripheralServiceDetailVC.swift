//
//  SFCMPeripheralServiceDetailVC.swift
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


// MARK: - SFCMPeripheralServiceDetailVC
class SFCMPeripheralServiceDetailVC: SFViewController {
    // MARK: var
    var navTitle: String?
    var navTitleDidChangedBlock: ((String?)->())?
    
    lazy var servicesView: SFOutlineView = {
        return SFOutlineView().then { view in
            let titleView = SFCMPeripheralDetailTitleView()
            titleView.titleLabel.text = R.string.localizable.central_bar_service()
            view.tableView.tableHeaderView = titleView
            view.backgroundColor = .clear
            view.tableView.backgroundColor = .clear
        }
    }()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customLayoutOfServiceDetailVC()
    }
    
    // MARK: ui
    private func customLayoutOfServiceDetailVC() {
        view.addSubview(servicesView)
        servicesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
