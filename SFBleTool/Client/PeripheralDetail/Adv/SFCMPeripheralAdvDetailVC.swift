//
//  SFCMPeripheralAdvDetailVC.swift
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


// MARK: - SFCMPeripheralAdvDetailVC
class SFCMPeripheralAdvDetailVC: SFTableViewController {
    // MARK: block
    var navTitleDidChangedBlock: ((String?)->())?
    
    // MARK: var
    var navTitle: String?        
    
    // MARK: data
    var items: [SFCMPeripheralAdvDetailItem] = [
        .localName,
        .manufacturer,
        .specificService,
        .serviceUuid,
        .overflowUuid,
        .txPower,
        .connectable,
        .solicitedUuid,
    ]
    var model: PeripheralModel? {
        didSet {
            
        }
    }
    
    // MARK: life cycle
    convenience init() {
        self.init(style: .plain)
    }
    
    private override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: setup
    private func setup() {
//        let titleView = SFCMPeripheralDetailTitleView()
//        titleView.frame = CGRect(origin: .zero, size: CGSize(width: 0, height: titleView.titleHeight))
//        titleView.titleLabel.text = R.string.localizable.central_detail_item_adv()
//        tableView.tableHeaderView = titleView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SFCMPeripheralAdvDetailCell.self)
        tableView.separatorStyle = .none
    }
    
}

// MARK: - UIScrollViewDelegate
extension SFCMPeripheralAdvDetailVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFCMPeripheralAdvDetailCell.self)
        cell.item = items[indexPath.row]
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
extension SFCMPeripheralAdvDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let oldNavTitle: String? = navTitle
        let offsetY = scrollView.contentOffset.y
        if offsetY >= 60 {
//            let newNavTitle: String? = R.string.localizable.central_detail_item_adv()
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
