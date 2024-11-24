//
//  OptionInfoVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: OptDetailVC
class OptDetailVC: SFScrollViewController {
    // MARK: var

    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: ui
    lazy var nameView: OptStringItemView = {
        return OptStringItemView().then { view in
            view.titleLabel.text = "Name"
        }
    }()
    private lazy var editBtn: SFButton = {
        return SFButton().then { view in
            view.setTitle("Edit", for: .normal)
            view.setTitle("Save", for: .selected)
            view.setTitleColor(SFColor.UI.title, for: .normal)
            view.setTitleColor(SFColor.UI.title, for: .selected)
            view.addTarget(self, action: #selector(editBtnClicked), for: .touchUpInside)
        }
    }()
    func customUI() {
        scrollView.contentView.addSubview(nameView)
        nameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: func
    func editOrSave(_ editEnable: Bool) {
        nameView.editEnable = editEnable
    }
}

// MARK: - Action
extension OptDetailVC {
    @objc func editBtnClicked() {
        editBtn.toggleSelected()
        let editEnable = editBtn.isSelected
        editOrSave(editEnable)
    }
}

