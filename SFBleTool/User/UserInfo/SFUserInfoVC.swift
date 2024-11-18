//
//  SFUserInfoVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/2.
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


// MARK: - SFUserInfoVC
class SFUserInfoVC: SFTableViewController {
    // MARK: data
    var items: [[SFUserInfoItem]] = [
        [.account],
        [.avatar, .nickname, .gender, .motto],
        [.phone, .email],
        [.birthday, .address],
    ]
    
    // MARK: init
    convenience init() {
        self.init(style: .grouped)
    }
    
    private override init(style: UITableView.Style) {
        super.init(style: style)
        setUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.user_info()
    }
    
    // MARK: setup
    private func setUp() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SFUserInfoImageCell.self)
        tableView.register(cellType: SFUserInfoValueCell.self)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SFUserInfoVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section][indexPath.row]
        if item == .avatar {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFUserInfoImageCell.self)
            cell.item = item
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFUserInfoValueCell.self)
            cell.item = item
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
