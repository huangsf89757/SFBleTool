//
//  SFCMPeripheralDetailBarView.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/14.
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


// MARK: - SFCMPeripheralDetailBarView
class SFCMPeripheralDetailBarView: SFShadowView {
    // MARK: var
    var selectedIndex = 0 {
        didSet {
            updateSelectedIndex()
        }
    }
    
    private lazy var advBtn: SFButton = {
        return SFButton().then { view in
            view.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
            view.setTitle(R.string.localizable.central_bar_adv(), for: .normal)
            view.setTitleColor(R.color.placeholder(), for: .normal)
            view.setTitleColor(R.color.theme(), for: .selected)
            view.setImage(R.image.bar.adv.nor(), for: .normal)
            view.setImage(R.image.bar.adv.sel(), for: .selected)
            view.style = .top(6)
            view.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
            view.tag = 0
        }
    }()
    private lazy var serviceBtn: SFButton = {
        return SFButton().then { view in
            view.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
            view.setTitle(R.string.localizable.central_bar_service(), for: .normal)
            view.setTitleColor(R.color.placeholder(), for: .normal)
            view.setTitleColor(R.color.theme(), for: .selected)
            view.setImage(R.image.bar.service.nor(), for: .normal)
            view.setImage(R.image.bar.service.sel(), for: .selected)
            view.style = .top(6)
            view.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
            view.tag = 1
        }
    }()
    private lazy var logBtn: SFButton = {
        return SFButton().then { view in
            view.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
            view.setTitle(R.string.localizable.central_bar_log(), for: .normal)
            view.setTitleColor(R.color.placeholder(), for: .normal)
            view.setTitleColor(R.color.theme(), for: .selected)
            view.setImage(R.image.bar.log.nor(), for: .normal)
            view.setImage(R.image.bar.log.sel(), for: .selected)
            view.style = .top(6)
            view.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
            view.tag = 2
        }
    }()
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customLayoutOfBarView()
        updateSelectedIndex()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: override
    override func customShapePath(rect: CGRect) -> UIBezierPath? {
        return UIBezierPath(roundedRect: rect, cornerRadius: 15)
    }
    
    // MARK: ui
    private func customLayoutOfBarView() {
        addSubview(advBtn)
        addSubview(serviceBtn)
        addSubview(logBtn)
        
        serviceBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        advBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(serviceBtn.snp.leading)
            make.width.equalTo(serviceBtn)
        }
        logBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(serviceBtn.snp.trailing)
            make.trailing.equalToSuperview()
            make.width.equalTo(serviceBtn)
        }
    }
}

// MARK: - action
extension SFCMPeripheralDetailBarView {
    @objc private func btnClicked(_ sender: SFButton) {
        selectedIndex = sender.tag
        updateSelectedIndex()
    }
    
    private func updateSelectedIndex() {
        advBtn.isSelected = selectedIndex == 0
        serviceBtn.isSelected = selectedIndex == 1
        logBtn.isSelected = selectedIndex == 2
    }
}
