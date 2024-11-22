//
//  SFUserInfoImageCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/14.
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


// MARK: - SFUserInfoImageCell
class SFUserInfoImageCell: SFUserInfoCell {    
    // MARK: ui
    private lazy var imgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.backgroundColor = R.color.placeholder()
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    override func customUI() {
        super.customUI()
        addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalTo(detailImgView.snp.leading).offset(-10)
            make.width.height.equalTo(60)
        }
    }
}

