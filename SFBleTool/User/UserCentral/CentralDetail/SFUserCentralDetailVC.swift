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
    var isEdit = false {
        didSet {
            editBtn.isHidden = isEdit
            tableView.tableFooterView = isEdit ? footerView : UIView()
            tableView.reloadData()
        }
    }
    
    // MARK: data
    let model = SFUserCentralDetailModel()
    let titles = [
        R.string.localizable.user_central_detail_init(),
        R.string.localizable.user_central_detail_scan(),
        R.string.localizable.user_central_detail_connect(),
    ]
    let items: [[SFUserCentralDetailItem]] = [
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editBtn)
        setupTableView()
    }
    
    // MARK: ui
    private lazy var editBtn: SFButton = {
        return SFButton().then { view in
            view.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            view.setTitleColor(R.color.title(), for: .normal)
            view.setTitle(R.string.localizable.com_edit(), for: .normal)
            view.addTarget(self, action: #selector(editBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var footerView: SFUserCenterDetailFooterView = {
        return SFUserCenterDetailFooterView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 100))).then { view in
            view.cancelBlock = { [weak self] in
                self?.isEdit.toggle()
            }
            view.saveBlock = { [weak self] in
                
            }
        }
    }()
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SFUserCentralDetailInlineCell.self)
        tableView.register(cellType: SFUserCentralDetailOutlineCell.self)
        tableView.separatorStyle = .none
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
        let item = items[indexPath.section][indexPath.row]
        var cell: SFUserCentralDetailCell
        if item == .restoreIdentifier || item == .solicitedServiceUUIDs {
            cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFUserCentralDetailOutlineCell.self)
            cell.item = item
        } else {
            cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFUserCentralDetailInlineCell.self)
            cell.item = item
        }
        cell.isEdit = isEdit
        switch item {
        case .showPowerAlert:
            cell.valueLabel.text = model.isShowPowerAlert.sf.toString
        case .restoreIdentifier:
            cell.valueLabel.text = model.restoreIdentifier ?? "nil"
        case .allowDuplicates:
            cell.valueLabel.text = model.isAllowDuplicates.sf.toString
        case .solicitedServiceUUIDs:
            var value = ""
            if let solicitedServiceUUIDs = model.solicitedServiceUUIDs {
                var uuidStrings = [String]()
                for uuid in solicitedServiceUUIDs {
                    uuidStrings.append(uuid.uuidString)
                }
                value = uuidStrings.joined(separator: "\n")
            } else {
                value = "nil"
            }
            cell.valueLabel.text = value
        case .enableAutoReconnect:
            cell.valueLabel.text = model.isEnableAutoReconnect?.sf.toString ?? "nil"
        case .enableTransportBridging:
            cell.valueLabel.text = model.isEnableTransportBridging?.sf.toString ?? "nil"
        case .notifyOnConnection:
            cell.valueLabel.text = model.isNotifyOnConnection.sf.toString
        case .notifyOnDisconnection:
            cell.valueLabel.text = model.isNotifyOnDisconnection.sf.toString
        case .notifyOnNotification:
            cell.valueLabel.text = model.isNotifyOnNotification.sf.toString
        case .requiresANCS:
            cell.valueLabel.text = model.isRequiresANCS?.sf.toString ?? "nil"
        case .startDelay:
            cell.valueLabel.text = model.startDelay?.sf.toString ?? "nil"
        }
        self.tableView.configPosition(cell: cell, at: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableView.card(cell: cell, at: indexPath)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
}

// MARK: - Action
extension SFUserCentralDetailVC {
    @objc private func editBtnClicked() {
        isEdit.toggle()
    }
}
