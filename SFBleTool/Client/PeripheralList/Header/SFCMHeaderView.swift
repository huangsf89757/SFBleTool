//
//  SFCMHeaderView.swift
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


// MARK: - SFCMHeaderView
class SFCMHeaderView: SFView {
    // MARK: block
    var searchDidChangedBlock: ((SFCMSearchModel?)->())? {
        didSet {
            searchView.searchDidChangedBlock = searchDidChangedBlock
        }
    }
    var sortDidChangedBlock: ((SFCMSortModel?) -> ())? {
        didSet {
            sortView.sortDidChangedBlock = sortDidChangedBlock
        }
    }
    
    // MARK: var
    
    
    // MARK: data
    var model: SFCMHeaderModel? {
        didSet {
            searchView.model = model?.search
            sortView.model = model?.sort
            filterView.model = model?.filter
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.background()
        customUI()
    }
    
    // MARK: ui
    private lazy var searchView: SFCMSearchView = {
        return SFCMSearchView()
    }()
    private lazy var filterBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(R.image.com.filter(), for: .normal)
            view.addTarget(self, action: #selector(filterBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var filterView: SFCMFilterView = {
        return SFCMFilterView()
    }()
    private lazy var sortView: SFCMSortView = {
        return SFCMSortView()
    }()
    private lazy var separatorView: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.divider()
        }
    }()
    private func customUI() {
        addSubview(searchView)
        addSubview(filterBtn)
        addSubview(sortView)
        addSubview(separatorView)
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        filterBtn.snp.makeConstraints { make in
            make.centerY.equalTo(searchView)
            make.leading.equalTo(searchView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        sortView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

// MARK: - click
extension SFCMHeaderView {
    @objc private func filterBtnClicked() {
        filterView.show()
    }
}
 
