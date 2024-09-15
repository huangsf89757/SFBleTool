//
//  SFCMPeripheralDetailVC.swift
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


// MARK: - SFCMPeripheralDetailVC
class SFCMPeripheralDetailVC: SFViewController {
    // MARK: data
    var model: SFCMPeripheralListModel? {
        didSet {
            headerView.model = model
        }
    }
    
    // MARK: child vc
    private lazy var advVc: SFCMPeripheralAdvDetailVC = {
        return SFCMPeripheralAdvDetailVC()
    }()
    private lazy var serviceVc: SFCMPeripheralServiceDetailVC = {
        return SFCMPeripheralServiceDetailVC()
    }()
    private lazy var logVc: SFCMPeripheralLogDetailVC = {
        return SFCMPeripheralLogDetailVC()
    }()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUI()
    }
    
    // MARK: ui
    private lazy var segmentView: SFCMPeripheralDetailSegmentView = {
        return SFCMPeripheralDetailSegmentView().then { view in
            view.didSelectedItemBlock = {
                [weak self] segmentView, index in
                self?.advVc.tableView.stopScrolling()
                self?.serviceVc.tableView.stopScrolling()
                self?.logVc.tableView.stopScrolling()
            }
        }
    }()
    private lazy var headerView: SFCMPeripheralDetailHeaderView = {
        return SFCMPeripheralDetailHeaderView()
    }()
    private lazy var scrollView: SFScrollView = {
        return SFScrollView(dir: .horizontal).then { view in
            view.isPagingEnabled = true
            view.delegate = self
        }
    }()
    
    private func customUI() {
        self.navigationItem.titleView = segmentView
        view.addSubview(headerView)
        view.addSubview(scrollView)
        scrollView.contentView.addSubview(advVc.view)
        scrollView.contentView.addSubview(serviceVc.view)
        scrollView.contentView.addSubview(logVc.view)
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        advVc.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(scrollView)
            make.leading.equalToSuperview()
        }
        serviceVc.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(scrollView)
            make.leading.equalTo(advVc.view.snp.trailing)
        }
        logVc.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(scrollView)
            make.leading.equalTo(serviceVc.view.snp.trailing)
            make.trailing.equalToSuperview()
        }
    }
}

/// TODO: page
// MARK: - UIScrollViewDelegate
extension SFCMPeripheralDetailVC: UIScrollViewDelegate {
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let offsetX = scrollView.contentOffset.x
//        let pageWidth = scrollView.frame.width
//        let curPage = Int(round(offsetX / pageWidth))
//        let targetPage: Int
//        
//        if velocity.x > 0 {
//            // 向右滑动
//            targetPage = curPage + 1
//        } else if velocity.x < 0 {
//            // 向左滑动
//            targetPage = curPage - 1
//        } else {
//            // 速度为0,根据当前位置决定
//            targetPage = round(scrollView.contentOffset.x / pageWidth)
//        }
//        
//        let newTargetOffset = max(0, min(targetPage, 1)) * pageWidth
//        targetContentOffset.pointee.x = newTargetOffset
//    }
//    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            snapToPage(scrollView)
//        }
//    }
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        snapToPage(scrollView)
//    }
//    
//    private func snapToPage(_ scrollView: UIScrollView) {
//        let pageWidth = scrollView.frame.width
//        let index = Int(round(scrollView.contentOffset.x / pageWidth))
//        let newOffset = CGFloat(index) * pageWidth
//        if scrollView.contentOffset.x != newOffset {
//            scrollView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: true)
//        }
//        self.segmentView.select(index: index, animated: true)
//    }
//    
//    private func changePage(to index: Int) {
//        let pageWidth = scrollView.frame.width
//        let newOffset = CGFloat(index) * pageWidth
//        if scrollView.contentOffset.x != newOffset {
//            scrollView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: true)
//        }
//    }
}
