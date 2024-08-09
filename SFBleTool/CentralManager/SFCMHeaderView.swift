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
    // MARK: var
    private lazy var searchView: SFCMSearchView = {
        return SFCMSearchView()
    }()
    private lazy var filterBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(R.image.com.filter(), for: .normal)
            view.addTarget(self, action: #selector(filterBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var sortView: SFCMSortView = {
        return SFCMSortView()
    }()
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.background()
        customLayoutOfHeaderView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    private func customLayoutOfHeaderView() {
        addSubview(searchView)
        addSubview(filterBtn)
        addSubview(sortView)
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
    }    
}

// MARK: - click
extension SFCMHeaderView {
    @objc private func filterBtnClicked() {
        guard let window = SFApp.keyWindow() else { return }
        let frame = sortView.convert(sortView.bounds, to: window)
        let filterView = SFCMFilterView().then { view in
            view.baseY = frame.maxY
        }
        filterView.show()
    }
}
 
