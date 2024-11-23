//
//  PeripheralListSortView.swift
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


// MARK: - PeripheralListSortView
class PeripheralListSortView: SFView {
    // MARK: block
    var sortDidChangedBlock: ((PeripheralListSortModel?) -> ())?
    
    // MARK: var
   
    
    // MARK: data
    var model: PeripheralListSortModel? {
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
            view.setTitle(SFText.Main.peripheral_list_sort_name, for: .normal)
            view.addTarget(self, action: #selector(nameBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var rssiBtn: SFButton = {
        return SFButton().then { view in
            view.style = .right(5)
            view.setTitle(SFText.Main.peripheral_list_sort_rssi, for: .normal)
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

extension PeripheralListSortView {
    @objc private func nameBtnClicked() {
        updateSort(medthod: .name)
        sortDidChangedBlock?(model)
    }
    
    @objc private func rssiBtnClicked() {
        updateSort(medthod: .rssi)
        sortDidChangedBlock?(model)
    }
    
    private func updateSort(medthod: PeripheralListSortModel.Medthod) {
        guard let model = model else { return }
        if model.medthod != medthod {
            model.sort = .none
        }
        model.medthod = medthod
        model.sort.switch()
        
        switch model.medthod {
        case .none:
            nameBtn.setImage(PeripheralListSortModel.Sort.none.image, for: .normal)
            nameBtn.setTitleColor(PeripheralListSortModel.Sort.none.color, for: .normal)
            nameBtn.titleLabel?.font = PeripheralListSortModel.Sort.none.font
            rssiBtn.setImage(PeripheralListSortModel.Sort.none.image, for: .normal)
            rssiBtn.setTitleColor(PeripheralListSortModel.Sort.none.color, for: .normal)
            rssiBtn.titleLabel?.font = PeripheralListSortModel.Sort.none.font
        case .name:
            nameBtn.setImage(model.sort.image, for: .normal)
            nameBtn.setTitleColor(model.sort.color, for: .normal)
            nameBtn.titleLabel?.font = model.sort.font
            rssiBtn.setImage(PeripheralListSortModel.Sort.none.image, for: .normal)
            rssiBtn.setTitleColor(PeripheralListSortModel.Sort.none.color, for: .normal)
            rssiBtn.titleLabel?.font = PeripheralListSortModel.Sort.none.font
        case .rssi:
            nameBtn.setImage(PeripheralListSortModel.Sort.none.image, for: .normal)
            nameBtn.setTitleColor(PeripheralListSortModel.Sort.none.color, for: .normal)
            nameBtn.titleLabel?.font = PeripheralListSortModel.Sort.none.font
            rssiBtn.setImage(model.sort.image, for: .normal)
            rssiBtn.setTitleColor(model.sort.color, for: .normal)
            rssiBtn.titleLabel?.font = model.sort.font
        }
    }
}

extension PeripheralListSortView {
   
}
