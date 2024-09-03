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
    // MARK: block
    var navTitleDidChangedBlock: ((String?)->())?
    
    // MARK: var
    var navTitle: String?
        
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    
    // MARK: ui
    lazy var servicesView: SFOutlineView = {
        return SFOutlineView().then { view in
            let titleView = SFCMPeripheralDetailTitleView()
            titleView.frame = CGRect(origin: .zero, size: CGSize(width: 0, height: titleView.titleHeight))
            titleView.titleLabel.text = R.string.localizable.central_bar_service()
            view.tableView.tableHeaderView = titleView
            view.backgroundColor = .clear
            view.tableView.backgroundColor = .clear
        }
    }()
    private func customUI() {
        view.addSubview(servicesView)
        servicesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
