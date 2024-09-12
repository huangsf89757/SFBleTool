//
//  SFUserCenterVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/2.
//

import Foundation
import UIKit
import CoreBluetooth
// Basic
import SFBase
import SFExtension
// UI
import SFUI
// Server
import SFLogger
import SFBluetooth


// MARK: - SFUserCenterVC
class SFUserCenterVC: SFViewController {
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isHiddenNavBar = true
        customUI()
        
        headerView.model = SFUserManager.shared.curUser
    }
    
    // MARK: ui
    private lazy var headerView: SFUserCenterHeaderView = {
        return SFUserCenterHeaderView()
    }()
    private lazy var tableView: SFTableView = {
        return SFTableView().then { view in
            view.delegate = self
            view.dataSource = self
            view.register(cellType: SFUserCenterItemCell.self)
        }
    }()
    private func customUI() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SFUserCenterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFUserCenterItemCell.self)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
