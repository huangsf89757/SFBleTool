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
class SFCMPeripheralServiceDetailVC: SFOutlineViewController {
    // MARK: block
    var navTitleDidChangedBlock: ((String?)->())?
    
    // MARK: var
    var navTitle: String?
        
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: setup
    private func setup() {
//        let titleView = SFCMPeripheralDetailTitleView()
//        titleView.frame = CGRect(origin: .zero, size: CGSize(width: 0, height: titleView.titleHeight))
//        titleView.titleLabel.text = R.string.localizable.central_detail_item_service()
//        tableView.tableHeaderView = titleView
    }
}
