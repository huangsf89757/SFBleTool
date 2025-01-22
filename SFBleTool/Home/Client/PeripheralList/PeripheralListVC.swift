//
//  PeripheralListVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
//

import Foundation
import UIKit
import CoreBluetooth
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Server
import SFLogger
import SFBluetooth
// Third
import SideMenu
import Macaw

// MARK: - PeripheralListVC
class PeripheralListVC: HomeVC {
    
    // MARK: var
    /// 顶部/底部 Bar 是否显示
    private var isBarShowing = true
   
    // MARK: data
    var headerModel = PeripheralListHeaderModel() {
        didSet {
            headerView.model = headerModel
        }
    }
    /// 扫描到的设备
    var discoveredModels = [PeripheralModel]()
    /// 显示的设备
    var showModels = [PeripheralModel]()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.Main.peripheral_list
        customUI()
        configCentralManager()
        headerView.model = headerModel
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scanBtn.sf.applyCornerAndShadow()
    }
    
    
    // MARK: ui
    private lazy var headerView: PeripheralListHeader = {
        return PeripheralListHeader().then { view in
            view.searchDidChangedBlock = {
                [weak self] searchModel in
                self?.reloadList()
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: false)
            }
            view.sortDidChangedBlock = {
                [weak self] sortModel in
                self?.reloadList()
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: false)
            }
        }
    }()
    lazy var tableView: SFTableView = {
        return SFTableView(frame: .zero, style: .plain).then { view in
            view.delegate = self
            view.dataSource = self
            view.register(cellType: PeripheralListCell.self)
        }
    }()
    private lazy var scanBtn: SFButton = {
        return SFButton().then { view in
            view.sf.setCornerAndShadow(radius: 10, fillColor: SFColor.UI.content, shadowColor: SFColor.UI.black, shadowOpacity: 0.3, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 5)
            view.style = .right(10)
            view.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
            view.setImage(SFImage.Main.Ble.Scan.nor, for: .normal)
            view.setImage(SFImage.Main.Ble.Scan.sel, for: .selected)
            view.setTitle(SFText.Main.peripheral_list_scan_paused, for: .normal)
            view.setTitle(SFText.Main.peripheral_list_scan_doing, for: .selected)
            view.setTitleColor(SFColor.UI.title, for: .normal)
            view.setTitleColor(SFColor.UI.theme, for: .selected)
            view.addTarget(self, action: #selector(scanBtnClicked), for: .touchUpInside)
            
            // anim
            let anim = CABasicAnimation(keyPath: "transform.rotation.z")
            anim.fromValue = 0
            anim.toValue = Double.pi * 2
            anim.repeatCount = HUGE
            anim.duration = 2
            anim.isRemovedOnCompletion = false
            anim.fillMode = .forwards
            view.imageView?.layer.add(anim, forKey: "scanBtn_doing")
            view.imageView?.layer.sf.pauseAnimation()
        }
    }()
    private func customUI() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(scanBtn)
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        scanBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: override
    override func settingAction() {
//        let vc = OptConfigVC()
//        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - func
extension PeripheralListVC {

}

// MARK: - action
extension PeripheralListVC {


    
    /// 点击扫描
    @objc private func scanBtnClicked() {
        SFNotify.show(title: "TITLE")
        
//        if scanBtn.isSelected {
//            bleCentralManager.stopScan(id: UUID())
//        } else {
//            bleCentralManager.scanForPeripherals(id: UUID(), services: headerModel.filter.uuids, options: nil)
//        }
    }
    
    private func updateScanBtn() {
        if scanBtn.isSelected {
            scanBtn.imageView?.layer.sf.resumeAnimation()
        } else {
            scanBtn.imageView?.layer.sf.pauseAnimation()
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension PeripheralListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PeripheralListCell.self)
        cell.model = showModels[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = showModels[indexPath.row]
        guard let peripheral = model.peripheral else {
            SFToast.show("peripheral=nil")
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
//        centralManager.connect(peripheral: model.peripheral, options: <#T##[String : Any]?#>)
        
        let vc = SFCMPeripheralDetailVC()
        vc.model = showModels[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UIScrollViewDelegate
extension PeripheralListVC {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if showModels.count == 0 {
            showBar()
        } else {
            if velocity.y < 0 {
                // 向上滑动，显示
                showBar()
            } else {
                // 向下滑动，隐藏
                hideBar()
            }
        }
    }
    
    private func showBar() {
        if isBarShowing {
            return
        }
        isBarShowing = true
        scanBtn.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
        }
        UIView.animate(withDuration: 0.24) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBar() {
        if !isBarShowing {
            return
        }
        isBarShowing = false
        scanBtn.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(50)
        }
        UIView.animate(withDuration: 0.24) {
            self.view.layoutIfNeeded()
        }
    }
}


// MARK: - BleCentralManager
extension PeripheralListVC {
    private func configCentralManager() {
//        let options: [String : Any] = [
//            CBCentralManagerOptionShowPowerAlertKey: true,
//            CBCentralManagerOptionRestoreIdentifierKey: SFApp.bundle,
//        ]
//        bleCentralManager = SFBleCentralManager(queue: nil, options: options)
    }
    /*
     let row = showModels.firstIndex { model in
         model.uuid == peripheral.identifier
     }
     if let row = row {
         let model = showModels[row]
         model.name = peripheral.name
         model.uuid = peripheral.identifier
         model.peripheral = peripheral
         model.rssi = RSSI.doubleValue
         model.advertisementData = advertisementData
         tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
         SFLogger.debug("更新 peripheral=\(peripheral.description)")
     } else {
         let model = PeripheralModel()
         model.name = peripheral.name
         model.uuid = peripheral.identifier
         model.peripheral = peripheral
         model.rssi = RSSI.doubleValue
         model.advertisementData = advertisementData
         discoveredModels.append(model)
         reloadList()
         SFLogger.debug("新增 peripheral=\(peripheral.description)")
     }
     */
}


extension PeripheralListVC {
    func reloadList() {
        // 过滤
        let search = headerModel.search
        let searchModels = discoveredModels.filter { model in
            if let keyword = search.keyword {
                let name = model.name ?? PeripheralModel.defaultName
                if name.sf.like("%\(keyword)%") {
                    return true
                } else {
                    return false
                }
            }
            return true
        }
        
        // 排序
        let sort = headerModel.sort
        let sortModels = searchModels.sorted { model1, model2 in
            switch sort.medthod {
            case .none:
                return false
            case .name:
                let name1 = model1.name ?? PeripheralModel.defaultName
                let name2 = model2.name ?? PeripheralModel.defaultName
                switch sort.sort {
                case .none:
                    return false
                case .asc:
                    return name1 < name2
                case .des:
                    return name1 > name2
                }
            case .rssi:
                guard let rssi1 = model1.rssi, let rssi2 = model2.rssi else { return false }
                switch sort.sort {
                case .none:
                    return false
                case .asc:
                    return rssi1 < rssi2
                case .des:
                    return rssi1 > rssi2
                }
            }
        }
        
        // 刷新
        showModels = sortModels
        tableView.reloadData()
    }
}
