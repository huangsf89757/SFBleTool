//
//  SFCMSearchView.swift
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


// MARK: - SFCMSearchView
class SFCMSearchView: SFTextField {
    // MARK: var
    private lazy var searchImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.com.search()?.sf.resize(to: CGSize(width: 20, height: 20))
            view.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
        }
    }()
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftView = searchImgView
        tintColor = R.color.primary()
        textColor = R.color.title()
        placeholderColor = R.color.placeholder()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = rect.height / 2.0
        layer.borderColor = R.color.placeholder()?.cgColor
        layer.borderWidth = 1
    }
    
}
