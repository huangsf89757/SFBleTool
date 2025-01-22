//
//  OptListViewController.swift
//  SFBleTool
//
//  Created by hsf on 2025/1/11.
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

// MARK: - OptListViewController
class OptListViewController: SFEditItemListViewController<OptListModel> {
    // MARK: init
    init() {
        super.init(style: .grouped)
    }
    private override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: func
    private func configTableView() {
        tableView.delegate = self
        tableView.delegate = self
        tableView.register(cellType: OptionListCell.self)
        tableView.register(cellType: OptAddCell.self)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OptListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = data?.items ?? []
        if state.isEditing {
            return items.count
        } else {
            return items.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = data?.items ?? []
        if !state.isEditing, indexPath.row == items.count {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptAddCell.self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptionListCell.self)
            let item = items[indexPath.row]
            cell.data = item
            cell.state = state
//            cell.selectBlcok = {
//                [weak self] _ in
//                self?.checkSelectAllOrNot()
//                self?.tableView.reloadData()
//            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath.row == models.count {
//            addNewOpt()
//        } else {
//            let model = models[indexPath.section]
//            modifyOldOpt(model: model)
//        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        SFCardStyleManager.updateCardPath(for: cell, at: indexPath, in: tableView)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
