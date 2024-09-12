//
//  SFSignInPageView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/11.
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


// MARK: - SFSignInPageView
class SFSignInPageView: SFScrollView {
    // MARK: block
    var pageDidChangedBlock: ((SFSignInPageView, Int) -> ())?
    
    // MARK: var
    var curPageIndex: Int = 0
    
    // MARK: life cycle
    convenience init() {
        self.init(dir: .horizontal)
    }
    private override init(dir: SFScrollView.Direction) {
        super.init(dir: dir)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        delegate = self
        customUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    private lazy var codeView: SFSignInCodeContentView = {
        return SFSignInCodeContentView()
    }()
    
    private lazy var pwdView: SFSignInPwdContentView = {
        return SFSignInPwdContentView()
    }()
    
    private func customUI() {
        contentView.addSubview(codeView)
        contentView.addSubview(pwdView)
        
        codeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(self).offset(-20)
            make.bottom.lessThanOrEqualToSuperview()
        }
        pwdView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(codeView.snp.trailing).offset(20)
            make.width.equalTo(self).offset(-20)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}

extension SFSignInPageView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = frame.width
        let curPage = floor(scrollView.contentOffset.x / pageWidth)
        let targetPage: CGFloat
        
        if velocity.x > 0 {
            // 向右滑动
            targetPage = curPage + 1
        } else if velocity.x < 0 {
            // 向左滑动
            targetPage = curPage - 1
        } else {
            // 速度为0,根据当前位置决定
            targetPage = round(scrollView.contentOffset.x / pageWidth)
        }
        
        let newTargetOffset = max(0, min(targetPage, 1)) * pageWidth
        targetContentOffset.pointee.x = newTargetOffset
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapToPage(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToPage(scrollView)
    }
    
    private func snapToPage(_ scrollView: UIScrollView) {
        let pageWidth = frame.width
        let curPageIndex = Int(round(scrollView.contentOffset.x / pageWidth))
        let newOffset = curPageIndex > 0 ? (scrollView.contentSize.width - pageWidth) : 0
        if scrollView.contentOffset.x != newOffset {
            scrollView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: true)
        }
        self.curPageIndex = curPageIndex
        pageDidChangedBlock?(self, curPageIndex)
    }
    
    func changePage(to index: Int) {
        curPageIndex = index
        let pageWidth = frame.width
        let newOffset = curPageIndex > 0 ? (contentSize.width - pageWidth) : 0
        if contentOffset.x != newOffset {
            setContentOffset(CGPoint(x: newOffset, y: 0), animated: true)
        }
    }
}
