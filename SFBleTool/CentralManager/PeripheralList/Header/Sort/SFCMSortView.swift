//
//  SFCMSortView.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/7.
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


// MARK: - SFCMSortView
class SFCMSortView: SFView {
    // MARK: block
    var sortChangedBlock: ((SFCMSortModel?) -> ())?
    
    // MARK: var
   
    
    // MARK: data
    var model: SFCMSortModel? {
        didSet {
            updateSortIcon()
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.background()
        customUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    private lazy var nameBtn: SFButton = {
        return SFButton().then { view in
            view.style = .right(5)
            view.setImage(R.image.com.sort.none(), for: .normal)
            view.setTitleColor(R.color.title(), for: .normal)
            view.setTitle(R.string.localizable.central_sort_name(), for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            view.addTarget(self, action: #selector(nameBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var rssiBtn: SFButton = {
        return SFButton().then { view in
            view.style = .right(5)
            view.setImage(R.image.com.sort.none(), for: .normal)
            view.setTitleColor(R.color.title(), for: .normal)
            view.setTitle(R.string.localizable.central_sort_RSSI(), for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            view.addTarget(self, action: #selector(rssiBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var separatorView: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.divider()
        }
    }()
    private func customUI() {
        addSubview(nameBtn)
        addSubview(separatorView)
        addSubview(rssiBtn)
        
        nameBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(separatorView.snp.leading)
        }
        separatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 1, height: 20))
        }
        rssiBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(separatorView.snp.leading)
        }
    }
}

extension SFCMSortView {
    @objc private func nameBtnClicked() {
        model?.name.switch()
        updateSortIcon()
        sortChangedBlock?(model)
    }
    
    @objc private func rssiBtnClicked() {
        model?.rssi.switch()
        updateSortIcon()
        sortChangedBlock?(model)
    }
}

extension SFCMSortView {
    private func updateSortIcon() {
        nameBtn.setImage(model?.name.image, for: .normal)
        rssiBtn.setImage(model?.rssi.image, for: .normal)
        nameBtn.setTitleColor(model?.name.color, for: .normal)
        rssiBtn.setTitleColor(model?.rssi.color, for: .normal)
    }
}
