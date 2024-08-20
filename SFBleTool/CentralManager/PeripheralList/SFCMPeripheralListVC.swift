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
    private var models = [SFCMPeripheralListModel]()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.entrance_opt_central_title()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: scanBtn)
        customLayoutOfCentralManagerVC()
        // ble
        configCentralManager()
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
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFCMPeripheralListCell.self)
        cell.nameLabel.text = model.name
        cell.uuidLabel.text = model.uuid?.uuidString
        cell.rssiView.rssi = model.rssi
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
        scanBtn.toggleSelected()
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
        let options = [
            CBCentralManagerOptionShowPowerAlertKey: true,
            CBCentralManagerOptionRestoreIdentifierKey: SFApp.bundle,
        ]
        centralManager = SFCentralManager(queue: nil, options: options)
        centralManager.isLogEnable = true
        centralManager.didUpdateStateBlock = {
            [weak self] centralManager in
            self?.centralManagerDidUpdateState(centralManager)
        }
        centralManager.willRestoreStateBlock = {
            [weak self] centralManager, dict in
            self?.centralManager(centralManager, willRestoreState: dict)
        }
        centralManager.didDiscoverPeripheralBlock = {
            [weak self] centralManager, peripheral, dict, rssi in
            self?.centralManager(centralManager, didDiscover: peripheral, advertisementData: dict, rssi: rssi)
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
    private func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
    
    private func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        
    }

    private func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
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
