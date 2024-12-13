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
            tableView.reloadData()
        }
    }
    
    // MARK: life cycle
    convenience init() {
        self.init(style: .plain)
    }
    private override init(style: UITableView.Style) {
        super.init(style: style)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: OptListCell.self)
        navigationItem.title = typeEnum.list
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: SFText.Main.opt_list_new, style: .plain, target: self, action: #selector(addItemClicked))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getModels()
    }
    
    // MARK: - func
    func addNew() {
        switch typeEnum {
        case .none:
            return
        case .client(let client):
            switch client {
            case .initial:
                let vc = OptDetailVC()
                vc.typeEnum = typeEnum
                let optModel = OptModel()
                optModel.default_clientInitial()
                vc.model = optModel
                navigationController?.pushViewController(vc, animated: true)
            case .scan:
                let vc = OptDetailVC()
                vc.typeEnum = typeEnum
                let optModel = OptModel()
                optModel.default_clientScan()
                vc.model = optModel
                navigationController?.pushViewController(vc, animated: true)
            case .connect:
                let vc = OptDetailVC()
                vc.typeEnum = typeEnum
                let optModel = OptModel()
                optModel.default_clientConnect()
                vc.model = optModel
                navigationController?.pushViewController(vc, animated: true)
            }
        case .server(let server):
            break
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OptListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptListCell.self)
        return cell
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
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - Action
extension OptListVC {
    @objc func addItemClicked() {
        addNew()
    }
}

// MARK: - Data
extension OptListVC {
    func getModels() {
        let logTag = "获取OptList数据"
        SFDbLogger.info(tag: logTag, step: .begin, port: .client, type: .find, msgs: "")
        if typeEnum == .none {
            models = []
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .find, msgs: "type=none")
            return
        }
        guard let user = UserModel.active, let uid = user.uid else {
            models = []
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .find, msgs: "uid=nil")
            return
        }
        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
            models = []
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .find, msgs: "userDb=nil")
            return
        }
        do {
            let condition = OptModel.Properties.type.is(typeEnum.code)
            let order = [OptModel.Properties.createTimeL.order(.descending)]
            let models: [OptModel] = try userDb.getObjects(on: OptModel.Properties.all, fromTable: OptModel.table, where: condition, orderBy: order)
            self.models = models
            SFDbLogger.info(tag: logTag, step: .success, port: .client, type: .find, msgs: "models.count=\(models.count)")
        } catch let error {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .find, msgs: error.localizedDescription)
        }
    }
}
