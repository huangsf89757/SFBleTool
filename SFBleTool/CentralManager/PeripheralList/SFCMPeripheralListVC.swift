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


// MARK: - SFCMPeripheralListVC
class SFCMPeripheralListVC: SFManagerVC {
    // MARK: var    
    private var centralManager: SFCentralManager!
   
    // MARK: data
    var headerModel = SFCMHeaderModel() {
        didSet {
            headerView.model = headerModel
        }
    }
    var listModels = [SFCMPeripheralListModel]()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.entrance_opt_central_title()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: scanBtn)
        customLayoutOfCentralManagerVC()
        configCentralManager()
        headerView.model = headerModel
    }
    
    
    // MARK: ui
    private lazy var scanBtn: SFButton = {
        return SFButton().then { view in
            view.style = .top(2)
            view.titleLabel?.font = .systemFont(ofSize: 8, weight: .regular)
            view.setImage(R.image.ble.scan.nor(), for: .normal)
            view.setImage(R.image.ble.scan.sel(), for: .selected)
            view.setTitle(R.string.localizable.central_ble_scan_paused(), for: .normal)
            view.setTitle(R.string.localizable.central_ble_scan_doing(), for: .selected)
            view.setTitleColor(R.color.subtitle(), for: .normal)
            view.setTitleColor(R.color.theme(), for: .selected)
            view.addTarget(self, action: #selector(scanBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var headerView: SFCMHeaderView = {
        return SFCMHeaderView()
    }()
    private lazy var tableView: SFTableView = {
        return SFTableView(frame: .zero, style: .plain).then { view in
            view.delegate = self
            view.dataSource = self
            view.register(cellType: SFCMPeripheralListCell.self)
        }
    }()
    private func customLayoutOfCentralManagerVC() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        
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
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension SFCMPeripheralListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFCMPeripheralListCell.self)
        cell.model = listModels[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SFCMPeripheralDetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - action
extension SFCMPeripheralListVC {
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
            let anim = CABasicAnimation(keyPath: "transform.rotation.z")
            anim.fromValue = 0
            anim.toValue = Double.pi * 2
            anim.repeatCount = HUGE
            anim.duration = 2
            anim.isRemovedOnCompletion = false
            anim.fillMode = .forwards
            scanBtn.imageView?.layer.add(anim, forKey: "scanBtn_doing")
        } else {
            scanBtn.imageView?.layer.removeAllAnimations()
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
        centralManager.isLogEnable = true
        centralManager.didChangedIsScanningBlock = {
            [weak self] centralManager, isScanning in
            self?.centralManagerDidChangedIsScanning(centralManager, isScanning: isScanning)
        }
        centralManager.didUpdateStateBlock = {
            [weak self] centralManager in
            self?.centralManagerDidUpdateState(centralManager)
        }
        centralManager.willRestoreStateBlock = {
            [weak self] centralManager, dict in
            self?.centralManager(centralManager, willRestoreState: dict)
        }
        centralManager.didDiscoverPeripheralBlock = {
            [weak self] centralManager, peripheral, data, rssi in
            self?.centralManager(centralManager, didDiscover: peripheral, advertisementData: data, rssi: rssi)
        }
        centralManager.didConnectPeripheralBlock = {
            [weak self] centralManager, peripheral in
            self?.centralManager(centralManager, didConnect: peripheral)
        }
        centralManager.didFailToConnectPeripheralBlock = {
            [weak self] centralManager, peripheral, error in
            self?.centralManager(centralManager, didFailToConnect: peripheral, error: error)
        }
        centralManager.didDisconnectPeripheralBlock = {
            [weak self] centralManager, peripheral, error in
            self?.centralManager(centralManager, didDisconnectPeripheral: peripheral, error: error)
        }
        centralManager.didDisconnectPeripheralAutoReconnectBlock = {
            [weak self] centralManager, peripheral, timestamp, isReconnecting, error in
            self?.centralManager(centralManager, didDisconnectPeripheral: peripheral, timestamp: timestamp, isReconnecting: isReconnecting, error: error)
        }
        centralManager.connectionEventDidOccurBlock = {
            [weak self] centralManager, event, peripheral in
            self?.centralManager(centralManager, connectionEventDidOccur: event, for: peripheral)
        }
        centralManager.didUpdateANCSAuthorizationForPeripheralBlock = {
            [weak self] centralManager, peripheral in
            self?.centralManager(centralManager, didUpdateANCSAuthorizationFor: peripheral)
        }
    }
}

// MARK: - SFCentralManagerDelegater
extension SFCMPeripheralListVC {
    private func centralManagerDidChangedIsScanning(_ central: CBCentralManager, isScanning: Bool) {
        scanBtn.isSelected = isScanning
        updateScanBtn()
    }
    
    private func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
    
    private func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        
    }

    private func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let row = listModels.firstIndex { model in
            model.uuid == peripheral.identifier
        }
        if let row = row {
            let model = listModels[row]
            model.peripheral = peripheral
            model.rssi = RSSI.doubleValue
            model.advData = advertisementData
            tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            Log.debug("更新")
        } else {
            let model = SFCMPeripheralListModel()
            model.peripheral = peripheral
            model.rssi = RSSI.doubleValue
            model.advData = advertisementData
            listModels.append(model)
            tableView.reloadData()
            Log.debug("新增")
        }
    }

    private func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
    }
 
    private func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?) {
        
    }

    private func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
       
    }

    private func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {
        
    }
   
    private func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        
    }

    private func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
        
    }
}
