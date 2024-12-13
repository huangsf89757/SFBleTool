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
    var typeEnum: OptType = .none
    var isEdit = false {
        didSet  {
            editBtn.isSelected = isEdit
            tableView.reloadData()
        }
    }
    
    // MARK: data
    var model: OptModel = OptModel() {
        didSet {
            tableView.reloadData()
        }
    }
    private var showItemModels = [OptItemModel]()
    
    // MARK: life cycle
    convenience init() {
        self.init(style: .grouped)
    }
    private override init(style: UITableView.Style) {
        super.init(style: style)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.Main.opt_detail
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 100
        tableView.register(headerFooterViewType: OptDetailHeader.self)
        tableView.register(cellType: OptDetailCell.self)
        tableView.register(cellType: OptDetailStringCell.self)
        tableView.register(cellType: OptDetailBoolCell.self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editBtn)
    }
    
    // MARK: ui
    private lazy var editBtn: SFButton = {
        return SFButton().then { view in
            view.setTitle(SFText.Main.com_edit, for: .normal)
            view.setTitle(SFText.Main.com_sure, for: .selected)
            view.setTitleColor(SFColor.UI.title, for: .normal)
            view.setTitleColor(SFColor.UI.title, for: .selected)
            view.addTarget(self, action: #selector(editBtnClicked), for: .touchUpInside)
        }
    }()
    
    // MARK: back
    override func willBack() -> (will: Bool, animated: Bool) {
        SFAlert.show(title: SFText.Main.opt_detail_save_title,
                     msg: SFText.Main.opt_detail_save_subtitle,
                     cancel: SFText.Main.com_cancel,
                     cancelActionBlock: { _ in
            return true
        },
                     sure: SFText.Main.com_sure,
                     sureActionBlock: { [weak self] popView in
            
            self?.goBack(animated: true)
            return true
        })
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
            [weak self] model in
            model.isSelected.toggle()
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
    }
}

// MARK: - Data
extension OptDetailVC {
    func saveModel() {
        let logTag = "保存Opt数据"
        SFDbLogger.info(tag: logTag, step: .begin, port: .client, type: .add, msgs: "")
        guard let user = UserModel.active, let uid = user.uid else {
            SFDbLogger.error(tag: logTag, step: .failure, port: .client, type: .find, msgs: "uid=nil")
            return
        }
        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
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
