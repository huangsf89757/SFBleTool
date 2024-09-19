//
//  SFUserCentralDetailVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/15.
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


// MARK: - SFUserCentralDetailVC
class SFUserCentralDetailVC: SFTableViewController {
    // MARK: var
    var isEdit = false
    
    // MARK: data
    var items: [[SFUserCentralDetailItem]] = [
        [.showPowerAlert, .restoreIdentifier],
        [.allowDuplicates, .solicitedServiceUUIDs],
        [.enableAutoReconnect, .enableTransportBridging, .notifyOnConnection, .notifyOnDisconnection, .notifyOnNotification, .requiresANCS, .startDelay]
    ]
    
    // MARK: life cycle
    convenience init() {
        self.init(style: .grouped)
    }
    
    private override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SFUserCentralDetailCell.self)
        tableView.register(cellType: SFUserCentralDetailEditCell.self)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SFUserCentralDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEdit {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFUserCentralDetailEditCell.self)
            cell.item = items[indexPath.section][indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFUserCentralDetailCell.self)
            cell.item = items[indexPath.section][indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isEdit {
            
        } else {
            self.tableView.card(cell: cell, at: indexPath)
        }
    }
}
