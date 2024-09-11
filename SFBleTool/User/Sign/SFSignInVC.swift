//
//  SFSignInVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/2.
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

// MARK: - SFSignInVC
class SFSignInVC: SFScrollViewController {
    // MARK: block
    
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.dir = .vertical
        super.viewDidLoad()
        customUI()
    }
    
    // MARK: ui
    private lazy var logoImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.backgroundColor = R.color.content()
            view.image = R.image.logo()
        }
    }()
    private lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = R.color.title()
            view.textAlignment = .center
            view.text = R.string.localizable.name()
        }
    }()
    private lazy var slogenLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 14, weight: .regular)
            view.textColor = R.color.subtitle()
            view.textAlignment = .center
            view.text = R.string.localizable.slogen()
        }
    }()
    
    private func customUI() {
        contentView.addSubview(logoImgView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(slogenLabel)
        
        logoImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImgView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        slogenLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
    }
}
