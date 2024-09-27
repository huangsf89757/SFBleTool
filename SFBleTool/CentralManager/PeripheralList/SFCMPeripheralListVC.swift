//
//  SFCMPeripheralListVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
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
import SFBluetooth
// Third
import SideMenu


// MARK: - SFCMPeripheralListVC
class SFCMPeripheralListVC: SFManagerVC {
    
    // MARK: var
    private var centralManager: SFCentralManager!
    /// 顶部/底部 Bar 是否显示
    private var isBarShowing = true
   
    // MARK: data
    var headerModel = SFCMHeaderModel() {
        didSet {
            headerView.model = headerModel
        }
    }
    /// 扫描到的设备
    var discoveredModels = [SFCMPeripheralListModel]()
    /// 显示的设备
    var showModels = [SFCMPeripheralListModel]()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        customUI()
        configCentralManager()
        headerView.model = headerModel
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scanBtn.sf.applyCornerAndShadow()
    }
    
    
    // MARK: ui
    private lazy var userBtn: SFButton = {
        return SFButton().then { view in
            view.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
            view.setImage(R.image.user.user(), for: .normal)
            view.addTarget(self, action: #selector(userBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var settingBtn: SFButton = {
        return SFButton().then { view in
            view.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
            view.setImage(R.image.com.setting(), for: .normal)
            view.addTarget(self, action: #selector(settingBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var headerView: SFCMHeaderView = {
        return SFCMHeaderView().then { view in
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
            view.register(cellType: SFCMPeripheralListCell.self)
        }
    }()
    private lazy var scanBtn: SFButton = {
        return SFButton().then { view in
            view.sf.setCornerAndShadow(radius: 10, fillColor: R.color.background(), shadowColor: R.color.black(), shadowOpacity: 0.3, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 5)
            view.style = .right(10)
            view.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
            view.setImage(R.image.ble.scan.nor(), for: .normal)
            view.setImage(R.image.ble.scan.sel(), for: .selected)
            view.setTitle(R.string.localizable.central_ble_scan_paused(), for: .normal)
            view.setTitle(R.string.localizable.central_ble_scan_doing(), for: .selected)
            view.setTitleColor(R.color.title(), for: .normal)
            view.setTitleColor(R.color.theme(), for: .selected)
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
}

// MARK: - func
extension SFCMPeripheralListVC {
    private func configNav() {
        navigationItem.title = R.string.localizable.entrance_opt_central_title()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingBtn)
//        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
//        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
}

// MARK: - action
extension SFCMPeripheralListVC {
    /// 点击用户
    @objc private func userBtnClicked() {
        let vc = SFUserCenterVC()
        let nav = SideMenuNavigationController(rootViewController: vc)
        nav.leftSide = true
        nav.menuWidth = SFApp.screenWidthPortrait() * 0.8
        present(nav, animated: true, completion: nil)
    }
    
    /// 点击设置
    @objc private func settingBtnClicked() {
        let vc = SFUserCentralDetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 点击扫描
    @objc private func scanBtnClicked() {
        if scanBtn.isSelected {
            centralManager.stopScan()
        } else {
            centralManager.scanForPeripherals(services: headerModel.filter.uuids, options: nil)
        }
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
extension SFCMPeripheralListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFCMPeripheralListCell.self)
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
extension SFCMPeripheralListVC {
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

// MARK: - CBCentralManager
extension SFCMPeripheralListVC {
    private func configCentralManager() {
        let options: [String : Any] = [
            CBCentralManagerOptionShowPowerAlertKey: true,
            CBCentralManagerOptionRestoreIdentifierKey: SFApp.bundle,
        ]
        centralManager = SFCentralManager(queue: nil, options: options)
        addNotify()
    }
    
    private func addNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerIsScanningDidChanged(_:)), name: SF_Notify_CentralManager_IsScanning_DidChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerStateDidUpdated(_:)), name: SF_Notify_CentralManager_State_DidUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerANCSAuthorizationDidUpdated(_:)), name: SF_Notify_CentralManager_ANCSAuthorization_DidUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerWillRestoreState(_:)), name: SF_Notify_CentralManager_WillRestoreState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerRetrievePeripherals(_:)), name: SF_Notify_CentralManager_RetrievePeripherals, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerRetrieveConnectedPeripherals(_:)), name: SF_Notify_CentralManager_RetrieveConnectedPeripherals, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerScanStart(_:)), name: SF_Notify_CentralManager_Scan_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerScanStop(_:)), name: SF_Notify_CentralManager_Scan_Stop, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDidDiscoverPeripheral(_:)), name: SF_Notify_CentralManager_DidDiscoverPeripheral, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectPeripheralStart(_:)), name: SF_Notify_CentralManager_ConnectPeripheral_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectPeripheralSuccess(_:)), name: SF_Notify_CentralManager_ConnectPeripheral_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectPeripheralFailure(_:)), name: SF_Notify_CentralManager_ConnectPeripheral_Failure, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDisconnectPeripheralStart(_:)), name: SF_Notify_CentralManager_DisconnectPeripheral_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDisconnectPeripheralSuccess(_:)), name: SF_Notify_CentralManager_DisconnectPeripheral_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDisconnectPeripheralAutoReconnectSuccess(_:)), name: SF_Notify_CentralManager_DisconnectPeripheralAutoReconnect_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectionEventsRegister(_:)), name: SF_Notify_CentralManager_ConnectionEvents_Register, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectionEventsOccur(_:)), name: SF_Notify_CentralManager_ConnectionEvents_Occur, object: nil)
    }
    
    @objc private func notifyCentralManagerIsScanningDidChanged(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let isScanning = userInfo["isScanning"] as? Bool else { return }
        scanBtn.isSelected = isScanning
        updateScanBtn()
    }
    
    @objc private func notifyCentralManagerStateDidUpdated(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerANCSAuthorizationDidUpdated(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
    }
    
    @objc private func notifyCentralManagerWillRestoreState(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let dict = userInfo["dict"] as? [String : Any] else { return }
    }
    
    @objc private func notifyCentralManagerRetrievePeripherals(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let identifiers = userInfo["identifiers"] as? [UUID] else { return }
        guard let peripherals = userInfo["peripherals"] as? [CBPeripheral] else { return }
    }
    
    @objc private func notifyCentralManagerRetrieveConnectedPeripherals(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let identifiers = userInfo["identifiers"] as? [UUID] else { return }
        guard let peripherals = userInfo["peripherals"] as? [CBPeripheral] else { return }
    }
    
    @objc private func notifyCentralManagerScanStart(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        if let serviceUUIDs = userInfo["serviceUUIDs"] as? [CBUUID] {  }
        if let options = userInfo["options"] as? [String: Any] {  }
    }
    
    @objc private func notifyCentralManagerScanStop(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerDidDiscoverPeripheral(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
        guard let advertisementData = userInfo["advertisementData"] as? [String : Any] else { return }
        guard let RSSI = userInfo["RSSI"] as? NSNumber else { return }
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
            Log.debug("更新 peripheral=\(peripheral.sf.description)")
        } else {
            let model = SFCMPeripheralListModel()
            model.name = peripheral.name
            model.uuid = peripheral.identifier
            model.peripheral = peripheral
            model.rssi = RSSI.doubleValue
            model.advertisementData = advertisementData
            discoveredModels.append(model)
            reloadList()
            Log.debug("新增 peripheral=\(peripheral.sf.description)")
        }
    }
    
    @objc private func notifyCentralManagerConnectPeripheralStart(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerConnectPeripheralSuccess(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerConnectPeripheralFailure(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerDisconnectPeripheralStart(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerDisconnectPeripheralSuccess(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerDisconnectPeripheralAutoReconnectSuccess(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerConnectionEventsRegister(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerConnectionEventsOccur(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
}


