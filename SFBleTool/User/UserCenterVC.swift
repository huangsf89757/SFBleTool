//
//  UserCenterVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Business
import SFBusiness
import SFUser
// Server
import SFLogger

// MARK: - UserCenterVC
class UserCenterVC: SFViewController {
    // MARK: data

    var titles: [String] = [
        SFText.Main.userCenter_title_opt
    ]
    var items: [[UserCenterItem]] = [
        [.clientOptInit,.clientOptScan,.clientOptConnect]
    ]
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isHiddenNavBar = true
        customUI()
    }
    
    // MARK: ui
    private lazy var headerView: UserCenterHeader = {
        return UserCenterHeader().then { view in
            view.didClickAvatarBlock = {
                [weak self] in
                let vc = SFUser.InfoVC()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }()
    private lazy var tableView: SFTableView = {
        return SFTableView(frame: .zero, style: .grouped).then { view in
            view.backgroundColor = SFColor.UI.content
            view.delegate = self
            view.dataSource = self
            view.register(cellType: UserCenterCell.self)
        }
    }()
    private lazy var copyrightView: SFCopyrightView = {
        return SFCopyrightView()
    }()
    
    
    private func customUI() {
        view.backgroundColor = SFColor.UI.content
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(copyrightView)
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        copyrightView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UserCenterVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UserCenterCell.self)
        let item = items[indexPath.section][indexPath.row]
        cell.item = item
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.section][indexPath.row]
        switch item {
        case .clientOptInit:
            let vc = ClientInitialOptListVC()
            navigationController?.pushViewController(vc, animated: true)
        case .clientOptScan:
            let vc = ClientScanOptListVC()
            navigationController?.pushViewController(vc, animated: true)
        case .clientOptConnect:
            let vc = ClientConnectOptListVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
}

