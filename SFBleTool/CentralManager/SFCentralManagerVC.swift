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
    private lazy var settingBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(R.image.com.setting(), for: .normal)
        }
    }()
    private lazy var headerView: SFCMHeaderView = {
        return SFCMHeaderView().then { view in
            
        }
    }()
    private lazy var tableView: SFTableView = {
        return SFTableView(frame: .zero, style: .plain).then { view in
            view.delegate = self
            view.dataSource = self
            view.register(cellType: SFCMPeripheralCell.self)
        }
    }()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.entrance_opt_central_title()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingBtn)
        customLayoutOfCentralManagerVC()
    }
    
    
    // MARK: ui
    private func customLayoutOfCentralManagerVC() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SFCentralManagerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFCMPeripheralCell.self)
        cell.rssiView.rssi = -78
        cell.nameLabel.text = "AiDEX X-TEST000001"
        cell.uuidLabel.text = UUID().uuidString
        return cell
    }
}
