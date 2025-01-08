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
class OptListVC: SFViewController {
    
    // MARK: var
    var typeEnum: OptType = .none
    private var models = [OptModel]() {
        didSet {
            reloadData()
        }
    }
    var isEdit = false {
        didSet  {
            configHeaderRefresh()
            showOrHideEditView()
            reloadData()
        }
    }
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = typeEnum.list
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editBtn)
        customUI()
        configHeaderRefresh()
        showOrHideEditView()
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
    private lazy var tableView: SFTableView = {
        return SFTableView(frame: .zero, style: .grouped).then { view in
            view.delegate = self
            view.dataSource = self
            view.separatorStyle = .none
            view.register(cellType: OptAddCell.self)
            view.register(cellType: OptListCell.self)
        }
    }()
    private lazy var editView: OptListEditView = {
        return OptListEditView().then { view in
            view.isHidden = true
            view.selectBlcok = {
                [weak self] isSelectAll in
                self?.selectAllOrNot(isSelectAll)
            }
        }
    }()
    
    private func customUI() {
        view.addSubview(tableView)
        view.addSubview(editView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        editView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Func
extension OptListVC {
    private func configHeaderRefresh() {
        if isEdit {
            tableView.headerRefreshBlock = nil
        } else {
            tableView.headerRefreshBlock = {
                [weak self] in
                self?.editBtnEnable(false)
                self?.database_getList()
            }
        }
    }
    
    private func showOrHideEditView() {
        editView.isHidden = !isEdit
        editView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(isEdit ? 0 : 60)
        }
    }
    
    private func editBtnEnable(_ enable: Bool) {
        editBtn.isUserInteractionEnabled = enable
        editBtn.alpha = enable ? 1 : 0.3
    }
}

// MARK: - Seletc
extension OptListVC {
    private func checkSelectAllOrNot() {
        var isSelectAll = true
        for model in models {
            if !model.isSelected {
                isSelectAll = false
                break
            }
        }
        editView.isSelectAll = isSelectAll
    }
    
    private func selectAllOrNot(_ isSelected: Bool) {
        models.forEach { model in
            model.isSelected = isSelected
        }
        tableView.reloadData()
    }
}


extension OptListVC {
   private func addNewOpt() {
       let vc = OptDetailVC()
       let optModel = OptModel()
       optModel.defaultL()
       optModel.typeEnum = typeEnum
       
        switch typeEnum {
        case .none:
            return
        case .client(let client):
            switch client {
            case .initial:
                optModel.default_clientInitial()
            case .scan:
                optModel.default_clientScan()
            case .connect:
                optModel.default_clientConnect()
            }
        case .server(let server):
            break
        }
       
       vc.model = optModel
       vc.isEdit = true
       vc.isAddNew = true
       navigationController?.pushViewController(vc, animated: true)
    }
    
    private func modifyOldOpt(model: OptModel) {
        let vc = OptDetailVC()
        vc.model = model
        vc.isEdit = false
        vc.isAddNew = false
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OptListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEdit {
            return models.count
        } else {
            return models.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isEdit, indexPath.row == models.count {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptAddCell.self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptListCell.self)
            let model = models[indexPath.section]
            cell.model = model
            cell.isEdit = isEdit
            cell.selectBlcok = {
                [weak self] _ in
                self?.checkSelectAllOrNot()
                self?.tableView.reloadData()
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == models.count {
            addNewOpt()
        } else {
            let model = models[indexPath.section]
            modifyOldOpt(model: model)
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
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - Action
extension OptListVC {
    @objc func editBtnClicked() {
        editBtn.isSelected.toggle()
        isEdit = editBtn.isSelected
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
