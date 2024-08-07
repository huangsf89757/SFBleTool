//
//  SFCentralManagerVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
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

// MARK: - SFCentralManagerVC
class SFCentralManagerVC: SFManagerVC {
    // MARK: var
    private lazy var headerView: SFCMHeaderView = {
        return SFCMHeaderView().then { view in
            
        }
    }()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.entrance_opt_central_title()
        customLayoutOfCentralManagerVC()
    }
    
    
    // MARK: ui
    private func customLayoutOfCentralManagerVC() {
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
