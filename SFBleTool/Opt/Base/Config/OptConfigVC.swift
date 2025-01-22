////
////  OptConfigVC.swift
////  SFBleTool
////
////  Created by hsf on 2025/1/9.
////
//
//import Foundation
//import UIKit
//// Basic
//import SFExtension
//import SFBase
//// UI
//import SFUI
//// Business
//import SFBusiness
//import SFUser
//// Server
//import SFLogger
//// Third
//import WCDBSwift
//
//// MARK: OptConfigVC
//class OptConfigVC: SFEditViewController<[OptModel]> {
//    
//    // MARK: life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = SFText.Main.opt_config
//        saveAlertMsg = SFText.Main.opt_config_save_msg
//        self.data = []
//        self.isEditDidChangedBlock = {
//            [weak self] isEdit in
//            self?.tableView.reloadData()
//        }
//        customUI()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        database_get()
//    }
//    
//    // MARK: ui
//    private lazy var tableView: SFTableView = {
//        return SFTableView(frame: .zero, style: .grouped).then { view in
//            view.delegate = self
//            view.dataSource = self
//            view.separatorStyle = .none
//            view.register(cellType: OptConfigCell.self)
//        }
//    }()
//    
//    private func customUI() {
//        view.addSubview(tableView)
//        
//        tableView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
//    }
//}
//
//// MARK: - UITableViewDelegate, UITableViewDataSource
//extension OptConfigVC: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        let models = self.data ?? []
//        return models.count
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptConfigCell.self)
//        let models = self.data ?? []
//        let model = models[indexPath.section]
//        cell.model = model
////        cell.isEdit = self.isEdit
//        cell.changeBlock = {
//            [weak self] model in
//            
//        }
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.tableView.card(cell: cell, at: indexPath)
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return nil
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return nil
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.1
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let models = self.data ?? []
//        let model = models[section]
//        return model.typeEnum.title
//    }
//}
//
//// MARK: - Data
//extension OptConfigVC {
//    private func database_get() {
//        let logTag = "获取正在使用的OptModel"
//        SFDatabaseLogger.info(port: .client, tag: logTag, step: .begin, type: .find, msgs: "")
//        guard let activeUser = UserModel.active else {
//            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .find, msgs: "activeUser=nil")
//            return
//        }
//        let uid = activeUser.uid
//        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
//            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .find, msgs: "userDb=nil")
//            return
//        }
//        do {
//            let condition_isActive = OptModel.Properties.isActive.is(false)
//            let order = [OptModel.Properties.updateTimeL.order(.descending)]
//            
//            let condition_initial = OptModel.Properties.type.is(OptType.client(.initial).code)
//            let model_initial: OptModel? = try userDb.getObject(on: OptModel.Properties.all, fromTable: OptModel.table, where: condition_isActive && condition_initial, orderBy: order)
//            model_initial?.valuesToModels()
//            
//            let condition_scan = OptModel.Properties.type.is(OptType.client(.scan).code)
//            let model_scan: OptModel? = try userDb.getObject(on: OptModel.Properties.all, fromTable: OptModel.table, where: condition_isActive && condition_scan, orderBy: order)
//            model_scan?.valuesToModels()
//            
//            let condition_connect = OptModel.Properties.type.is(OptType.client(.connect).code)
//            let model_connect: OptModel? = try userDb.getObject(on: OptModel.Properties.all, fromTable: OptModel.table, where: condition_isActive && condition_connect, orderBy: order)
//            model_connect?.valuesToModels()
//            
//            var models = [OptModel]()
//            if let model_initial = model_initial {
//                models.append(model_initial)
//            }
//            if let model_scan = model_scan {
//                models.append(model_scan)
//            }
//            if let model_connect = model_connect {
//                models.append(model_connect)
//            }
//            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .success, type: .find, msgs:
//                                    "model_initial=\(String(describing: model_initial))",
//                                    "model_scan=\(String(describing: model_scan))",
//                                    "model_connect=\(String(describing: model_connect))")
//            self.data = models
//            self.tableView.reloadData()
//        } catch let error {
//            SFDatabaseLogger.info(port: .client ,tag: logTag, step: .failure, type: .find, msgs: error.localizedDescription)
//        }
//    }
//}
