//
//  SFSignInInputView.swift
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


// MARK: - SFSignInInputView
class SFSignInInputView: SFScrollView {
    // MARK: block
    var modeDidChangedBlock: ((SFSignInMode) -> ())?
    
    // MARK: var
    var mode: SFSignInMode = .code
    
    // MARK: life cycle
    convenience init() {
        self.init(dir: .horizontal)
    }
    private override init(dir: SFScrollView.Direction) {
        super.init(dir: dir)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
        customUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    private lazy var codeView: SFSignInCodeInputView = {
        return SFSignInCodeInputView()
    }()
    
    private lazy var pwdView: SFSignInPwdInputView = {
        return SFSignInPwdInputView()
    }()
    
    private func customUI() {
        contentView.addSubview(codeView)
        contentView.addSubview(pwdView)
        
        codeView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(self)
            make.bottom.lessThanOrEqualToSuperview()
        }
        pwdView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(codeView.snp.trailing).offset(20)
            make.width.equalTo(self)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}

extension SFSignInInputView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.x > scrollView.frame.width / 2.0 {
            scrollView.scrollRectToVisible(CGRect(x: contentView.frame.width - scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
            mode = .pwd
        } else {
            scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
            mode = .code
        }
        modeDidChangedBlock?(mode)
    }
}
