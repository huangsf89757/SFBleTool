//
//  SFCMPeripheralLogDetailVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/14.
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


// MARK: - SFCMPeripheralLogDetailVC
class SFCMPeripheralLogDetailVC: SFViewController {
    // MARK: block
    var navTitleDidChangedBlock: ((String?)->())?
    
    // MARK: var
    var navTitle: String?
        
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    
    // MARK: ui
    lazy var tableView: SFTableView = {
        return SFTableView(frame: .zero, style: .plain).then { view in
            view.backgroundColor = .clear
//            let titleView = SFCMPeripheralDetailTitleView()
//            titleView.frame = CGRect(origin: .zero, size: CGSize(width: 0, height: titleView.titleHeight))
//            titleView.titleLabel.text = R.string.localizable.central_detail_item_log()
//            view.tableHeaderView = titleView
            view.delegate = self
            view.dataSource = self
            view.register(cellType: SFCMPeripheralLogCell.self)
            view.rowHeight = 50
        }
    }()
    private func customUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SFCMPeripheralLogDetailVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFCMPeripheralLogCell.self)
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

// MARK: - UIScrollViewDelegate
extension SFCMPeripheralLogDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let oldNavTitle: String? = navTitle
        let offsetY = scrollView.contentOffset.y
        if offsetY >= 60 {
//            let newNavTitle: String? = R.string.localizable.central_detail_item_log()
//            if newNavTitle != oldNavTitle {
//                navTitle = newNavTitle
//                navTitleDidChangedBlock?(navTitle)
//            }
        } else {
            let newNavTitle: String? = nil
            if newNavTitle != oldNavTitle {
                navTitle = nil
                navTitleDidChangedBlock?(navTitle)
            }
        }
    }
}
