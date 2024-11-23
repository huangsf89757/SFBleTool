//
//  SFCMSortView.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/7.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Server
import SFLogger


// MARK: - SFCMSortView
class SFCMSortView: SFView {
    // MARK: block
    var sortDidChangedBlock: ((SFCMSortModel?) -> ())?
    
    // MARK: var
   
    
    // MARK: data
    var model: SFCMSortModel? {
        didSet {
            guard let model = model else { return }
            updateSort(medthod: model.medthod)
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SFColor.UI.content
        customUI()
    }
    
    // MARK: ui
    private lazy var nameBtn: SFButton = {
        return SFButton().then { view in
            view.style = .right(5)
            view.setTitle(SFText.Main.client_list_sort_name, for: .normal)
            view.addTarget(self, action: #selector(nameBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var rssiBtn: SFButton = {
        return SFButton().then { view in
            view.style = .right(5)
            view.setTitle(SFText.Main.client_list_sort_rssi, for: .normal)
            view.addTarget(self, action: #selector(rssiBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var separatorView: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
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
        updateSort(medthod: .name)
        sortDidChangedBlock?(model)
    }
    
    @objc private func rssiBtnClicked() {
        updateSort(medthod: .rssi)
        sortDidChangedBlock?(model)
    }
    
    private func updateSort(medthod: SFCMSortModel.Medthod) {
        guard let model = model else { return }
        if model.medthod != medthod {
            model.sort = .none
        }
        model.medthod = medthod
        model.sort.switch()
        
        switch model.medthod {
        case .none:
            nameBtn.setImage(SFCMSortModel.Sort.none.image, for: .normal)
            nameBtn.setTitleColor(SFCMSortModel.Sort.none.color, for: .normal)
            nameBtn.titleLabel?.font = SFCMSortModel.Sort.none.font
            rssiBtn.setImage(SFCMSortModel.Sort.none.image, for: .normal)
            rssiBtn.setTitleColor(SFCMSortModel.Sort.none.color, for: .normal)
            rssiBtn.titleLabel?.font = SFCMSortModel.Sort.none.font
        case .name:
            nameBtn.setImage(model.sort.image, for: .normal)
            nameBtn.setTitleColor(model.sort.color, for: .normal)
            nameBtn.titleLabel?.font = model.sort.font
            rssiBtn.setImage(SFCMSortModel.Sort.none.image, for: .normal)
            rssiBtn.setTitleColor(SFCMSortModel.Sort.none.color, for: .normal)
            rssiBtn.titleLabel?.font = SFCMSortModel.Sort.none.font
        case .rssi:
            nameBtn.setImage(SFCMSortModel.Sort.none.image, for: .normal)
            nameBtn.setTitleColor(SFCMSortModel.Sort.none.color, for: .normal)
            nameBtn.titleLabel?.font = SFCMSortModel.Sort.none.font
            rssiBtn.setImage(model.sort.image, for: .normal)
            rssiBtn.setTitleColor(model.sort.color, for: .normal)
            rssiBtn.titleLabel?.font = model.sort.font
        }
    }
}

extension SFCMSortView {
   
}
