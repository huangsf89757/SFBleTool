//
//  SFEntranceVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
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

// MARK: - SFEntranceVC
class SFEntranceVC: SFScrollViewController {
    // MARK: block
    var didChooseEntranceOptBlock: ((Int) -> ())?
    
    // MARK: life cycle
    convenience init() {
        self.init(dir: .vertical)
    }
    
    private override init(dir: SFScrollView.Direction) {
        super.init(dir: dir)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    
    // MARK: ui
    private lazy var logoImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.layer.cornerRadius = 12
            view.layer.masksToBounds = true
            view.backgroundColor = SFColor.UI.content
//            view.image = R.image.logo()
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
        }
    }()
    private lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = SFColor.UI.title
            view.textAlignment = .center
//            view.text = R.string.localizable.name()
        }
    }()
    private lazy var slogenLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.subtitle
            view.textAlignment = .center
//            view.text = R.string.localizable.slogen()
        }
    }()
    private lazy var centralEntranceOptView: SFEntranceOptView = {
        return SFEntranceOptView().then { view in
            view.tag = 0
//            view.titleLabel.text = R.string.localizable.entrance_opt_central_title()
//            view.subtitleLabel.text = R.string.localizable.entrance_opt_central_subtitle()
            view.tapBlock = {
                [weak self] optView in
                self?.entranceOptViewTaped(optView)
            }
        }
    }()
    private lazy var peripheralEntranceOptView: SFEntranceOptView = {
        return SFEntranceOptView().then { view in
            view.tag = 1
//            view.titleLabel.text = R.string.localizable.entrance_opt_peripheral_title()
//            view.subtitleLabel.text = R.string.localizable.entrance_opt_peripheral_subtitle()
            view.tapBlock = {
                [weak self] optView in
                self?.entranceOptViewTaped(optView)
            }
        }
    }()
    private func customUI() {
        scrollView.contentView.addSubview(logoImgView)
        scrollView.contentView.addSubview(nameLabel)
        scrollView.contentView.addSubview(slogenLabel)
        scrollView.contentView.addSubview(centralEntranceOptView)
        scrollView.contentView.addSubview(peripheralEntranceOptView)
        
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
        centralEntranceOptView.snp.makeConstraints { make in
            make.top.equalTo(slogenLabel.snp.bottom).offset(80)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        peripheralEntranceOptView.snp.makeConstraints { make in
            make.top.equalTo(centralEntranceOptView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.lessThanOrEqualToSuperview().offset(-100)
        }
    }
}

// MARK: action
extension SFEntranceVC {
    private func entranceOptViewTaped(_ sender: SFEntranceOptView) {
        centralEntranceOptView.isSelected = (sender === centralEntranceOptView)
        peripheralEntranceOptView.isSelected = (sender === peripheralEntranceOptView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.didChooseEntranceOptBlock?(sender.tag)
        }
    }
}
