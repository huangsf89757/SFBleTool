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
    // MARK: var
    var sortChangedBlock: ((Bool, Bool) -> ())?
    
    private lazy var nameBtn: SFButton = {
        return SFButton().then { view in
            view.style = .right(5)
            view.setImage(R.image.com.sort.up(), for: .normal)
            view.setImage(R.image.com.sort.down(), for: .selected)
            view.setTitleColor(R.color.title(), for: .normal)
            view.setTitleColor(R.color.title(), for: .selected)
            view.setTitle(R.string.localizable.central_sort_name(), for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            view.addTarget(self, action: #selector(nameBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var rssiBtn: SFButton = {
        return SFButton().then { view in
            view.style = .right(5)
            view.setImage(R.image.com.sort.up(), for: .normal)
            view.setImage(R.image.com.sort.down(), for: .selected)
            view.setTitleColor(R.color.title(), for: .normal)
            view.setTitleColor(R.color.title(), for: .selected)
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
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customLayoutOfSortView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    private func customLayoutOfSortView() {
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
        nameBtn.toggleSelected()
        sortChangedBlock?(nameBtn.isSelected, rssiBtn.isSelected)
    }
    
    @objc private func rssiBtnClicked() {
        rssiBtn.toggleSelected()
        sortChangedBlock?(nameBtn.isSelected, rssiBtn.isSelected)
    }
}
