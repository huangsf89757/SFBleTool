//
//  OptListVC.swift
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

// MARK: OptListVC
class OptListVC: SFTableViewController {
    
    // MARK: var
    var typeEnum: OptType = .none
    private var models = [OptModel]() {
        didSet {
            reloadData()
        }
    }
    
    // MARK: life cycle
    convenience init() {
        self.init(style: .grouped)
    }
    private override init(style: UITableView.Style) {
        super.init(style: style)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: OptAddCell.self)
        tableView.register(cellType: OptListCell.self)
        tableView.headerRefreshBlock = {
            [weak self] in
            self?.editBtnEnable(false)
            self?.database_getList()
        }
        navigationItem.title = typeEnum.list
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editBtn)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        database_getList()
    }
    
    // MARK: ui
    private lazy var editBtn: SFButton = {
        return SFButton().then { view in
            view.setTitle(SFText.UI.com_edit, for: .normal)
            view.setTitle(SFText.UI.com_save, for: .selected)
            view.setTitleColor(SFColor.UI.title, for: .normal)
            view.setTitleColor(SFColor.UI.title, for: .selected)
            view.addTarget(self, action: #selector(editBtnClicked), for: .touchUpInside)
        }
    }()
    
    // MARK: - func
    private func addNew() {
        switch typeEnum {
        case .none:
            return
        case .client(let client):
            switch client {
            case .initial:
                let vc = OptDetailVC()
                let optModel = OptModel()
                optModel.typeEnum = typeEnum
                optModel.default_clientInitial()
                vc.model = optModel
                vc.isEdit = true
                vc.isAddNew = true
                navigationController?.pushViewController(vc, animated: true)
            case .scan:
                let vc = OptDetailVC()
                let optModel = OptModel()
                optModel.typeEnum = typeEnum
                optModel.default_clientScan()
                vc.model = optModel
                vc.isEdit = true
                vc.isAddNew = true
                navigationController?.pushViewController(vc, animated: true)
            case .connect:
                let vc = OptDetailVC()
                let optModel = OptModel()
                optModel.typeEnum = typeEnum
                optModel.default_clientConnect()
                vc.model = optModel
                vc.isEdit = true
                vc.isAddNew = true
                navigationController?.pushViewController(vc, animated: true)
            }
        case .server(let server):
            break
        }
    }
    
    private func editBtnEnable(_ enable: Bool) {
        editBtn.isUserInteractionEnabled = enable
        editBtn.alpha = enable ? 1 : 0.3
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OptListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == models.count {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptAddCell.self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptListCell.self)
            let model = models[indexPath.section]
            cell.model = model
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == models.count {
            addNew()
        } else {
            let model = models[indexPath.section]
            let vc = OptDetailVC()
            vc.model = model
            vc.isEdit = false
            vc.isAddNew = false
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableView.card(cell: cell, at: indexPath)
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

// MARK: - Action
extension OptListVC {
    @objc func editBtnClicked() {
        
    }
}

// MARK: - Data
extension OptListVC {
    private func reloadData() {
        tableView.mj_header?.endRefreshing()
        editBtnEnable(true)
        tableView.reloadData()
    }
}
extension OptListVC {
    private func database_getList() {
        let logTag = "获取OptList"
        SFDatabaseLogger.info(port: .client, tag: logTag, step: .begin, type: .find, msgs: "")
        guard let activeUser = UserModel.active else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .find, msgs: "activeUser=nil")
            return
        }
        guard let uid = activeUser.uid else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .find, msgs: "uid=nil")
            return
        }
        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .find, msgs: "userDb=nil")
            return
        }
        guard typeEnum != .none else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .find, msgs: "type=none")
            return
        }
        do {
            let condition = OptModel.Properties.type.is(typeEnum.code)
            let order = [OptModel.Properties.createTimeL.order(.descending)]
            let models: [OptModel] = try userDb.getObjects(on: OptModel.Properties.all, fromTable: OptModel.table, where: condition, orderBy: order)
            models.forEach { model in
                model.valuesToModels()
            }
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .success, type: .find, msgs: "models.count=\(models.count)")
            self.models = models
            self.reloadData()
        } catch let error {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .find, msgs: error.localizedDescription)
        }
    }
}
