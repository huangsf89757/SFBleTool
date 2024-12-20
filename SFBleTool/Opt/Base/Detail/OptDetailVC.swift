//
//  OptionInfoVC.swift
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

// MARK: OptDetailVC
class OptDetailVC: SFTableViewController {
    // MARK: var
    var isEdit = false {
        didSet  {
            editBtn.isSelected = isEdit
        }
    }
    
    // MARK: data
    var isAddNew = false
    var model_saved: OptModel!
    var model: OptModel = OptModel() {
        didSet {
            model_saved = model
            reloadData()
        }
    }
    private var showItemModels = [OptItemModel]()
    
    // MARK: life cycle
    convenience init() {
        self.init(style: .grouped)
    }
    private override init(style: UITableView.Style) {
        super.init(style: style)
        let model = OptModel()
        model.defaultL()
        self.model = model
        self.model_saved = model
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = nameView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 100
        tableView.register(headerFooterViewType: OptDetailHeader.self)
        tableView.register(cellType: OptDetailCell.self)
        tableView.register(cellType: OptDetailStringCell.self)
        tableView.register(cellType: OptDetailBoolCell.self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editBtn)
        reloadData()
    }
    
    // MARK: ui
    private lazy var nameView: OptDetailNameView = {
        return OptDetailNameView(frame: CGRect(origin: .zero, size: CGSize(width: SFApp.screenWidthPortrait()/2, height: 40)))
    }()
    private lazy var editBtn: SFButton = {
        return SFButton().then { view in
            view.setTitle(SFText.UI.com_edit, for: .normal)
            view.setTitle(SFText.UI.com_save, for: .selected)
            view.setTitleColor(SFColor.UI.title, for: .normal)
            view.setTitleColor(SFColor.UI.title, for: .selected)
            view.addTarget(self, action: #selector(editBtnClicked), for: .touchUpInside)
        }
    }()
    
    // MARK: back
    override func willBack() -> (will: Bool, animated: Bool) {
        if !isEdit, model == model_saved {
            return super.willBack()
        }
        SFAlert.config(title: SFText.UI.com_save, msg: SFText.Main.opt_detail_save_msg)
        SFAlert.addCancelAction(title: SFText.UI.com_cancel) { [weak self] alertView in
            self?.goBack(animated: true)
            return true
        }
        SFAlert.addConfirmAction(title: SFText.UI.com_sure) { [weak self] alertView in
            Task {
                self?.isEdit = false
                self?.reloadData()
                self?.addOrUpdate()
                self?.goBack(animated: true)
            }
            return true
        }
        SFAlert.show()
        return (false, false)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OptDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var showModels = [OptItemModel]()
        if isEdit {
            showModels = model.itemModels
        } else {
            showModels = model.selectedModels
        }
        self.showItemModels =  showModels
        return self.showItemModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OptDetailCell
        let itemModel = showItemModels[indexPath.row]
        switch itemModel.item.valueType {
        case .none:
            cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptDetailCell.self)
        case .string:
            cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptDetailStringCell.self)
        case .bool:
            cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptDetailBoolCell.self)
        }
        cell.model = itemModel
        cell.isEdit = isEdit
        cell.selectBlcok = {
            [weak self] _ in
            self?.tableView.reloadData()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(OptDetailHeader.self)
        header?.titleLabel.text = model.typeEnum.title
        header?.descLabel.text = model.typeEnum.desc
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - Action
extension OptDetailVC {
    @objc func editBtnClicked() {
        isEdit.toggle()
        reloadData()
        if isEdit == false {
            addOrUpdate()
        }
    }
}

// MARK: - Data
extension OptDetailVC {
    private func reloadData() {
        nameView.model = model
        nameView.isEdit = isEdit
        tableView.reloadData()
    }
}
extension OptDetailVC {
    private func addOrUpdate() {
        model.modelsToValues()
        let name = model.name ?? ""
        if name.isEmpty {
            SFToast.show(SFText.Main.opt_detail_hint_name)
            return
        }
        if isAddNew {
            database_add()
        } else {
            database_update()
        }
        SFHud.show(.success, msg: SFText.UI.com_save_success, stay: 2)
    }
}
extension OptDetailVC {
    private func database_add() {
        let logTag = "新增Opt"
        SFDatabaseLogger.info(port: .client, tag: logTag, step: .begin, type: .add, msgs: "")
        guard let activeUser = UserModel.active else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .add, msgs: "activeUser=nil")
            return
        }
        guard let uid = activeUser.uid else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .add, msgs: "uid=nil")
            return
        }
        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .add, msgs: "userDb=nil")
            return
        }
        guard model.typeEnum != .none else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .add, msgs: "type=none")
            return
        }
        do {
            try userDb.insertOrReplace([model], intoTable: OptModel.table)
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .success, type: .add, msgs: model)
            self.reloadData()
        } catch let error {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .add, msgs: error.localizedDescription)
        }
    }
    
    private func database_update() {
        let logTag = "更新Opt"
        SFDatabaseLogger.info(port: .client, tag: logTag, step: .begin, type: .update, msgs: "")
        guard let activeUser = UserModel.active else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .update, msgs: "activeUser=nil")
            return
        }
        guard let uid = activeUser.uid else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .update, msgs: "uid=nil")
            return
        }
        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .update, msgs: "userDb=nil")
            return
        }
        guard model.typeEnum != .none else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .update, msgs: "type=none")
            return
        }
        guard let idL = model.idL else {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .update, msgs: "idL=nil")
            return
        }
        do {
            let condition = OptModel.Properties.idL.is(idL)
            try userDb.update(table: OptModel.table, on: OptModel.Properties.all, with: model, where: condition)
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .success, type: .update, msgs: model)
            self.reloadData()
        } catch let error {
            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .update, msgs: error.localizedDescription)
        }
    }
}
