//
//  SFCMPeripheralListVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// UI
import SFUI
// Server
import SFLogger


// MARK: - SFCMPeripheralListVC
class SFCMPeripheralListVC: SFManagerVC {
    // MARK: var
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
        return SFCMHeaderView().then { view in
            view.filterBlock = {
                [weak self] in
                self?.filterView.show()
            }
        }
    }()
    private lazy var filterView: SFCMFilterView = {
        return SFCMFilterView()
    }()
    private lazy var tableView: SFTableView = {
        return SFTableView(frame: .zero, style: .plain).then { view in
            view.delegate = self
            view.dataSource = self
            view.register(cellType: SFCMPeripheralListCell.self)
        }
    }()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.entrance_opt_central_title()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: scanBtn)
        customLayoutOfCentralManagerVC()
    }
    
    
    // MARK: ui
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
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFCMPeripheralListCell.self)
        cell.rssiView.rssi = -78
        cell.nameLabel.text = "AiDEX X-TEST000001"
        cell.uuidLabel.text = UUID().uuidString
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SFCMPeripheralDetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - action
extension SFCMPeripheralListVC {
    /// 点击设置
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
//        let vc = SFCMSettingVC()
//        let menu = SideMenuNavigationController(rootViewController: vc)
//        menu.menuWidth = 300
//        menu.sf.updateBar(barTintColor: SFColor.background, tintColor: SFColor.title, titleColor: SFColor.title, titleFont: .systemFont(ofSize: 20, weight: .bold))
//        present(menu, animated: true)
    }
}
