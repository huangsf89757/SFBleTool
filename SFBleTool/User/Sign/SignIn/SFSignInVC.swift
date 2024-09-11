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
    convenience init() {
        self.init(dir: .vertical)
    }
    private override init(dir: SFScrollView.Direction) {
        super.init(dir: dir)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    
    // MARK: ui
    private lazy var logoImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.backgroundColor = R.color.content()
            view.image = R.image.logo()
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
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
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = R.color.subtitle()
            view.textAlignment = .center
            view.text = R.string.localizable.slogen()
        }
    }()
    private lazy var modeView: SFSignInModeView = {
        return SFSignInModeView()
    }()
    private lazy var contentView: SFSignInPageView = {
        return SFSignInPageView().then { view in
            view.modeDidChangedBlock = {
                [weak self] mode in
                switch mode {
                case .code:
                    self?.modeView.selectedIndex = 0
                case .pwd:
                    self?.modeView.selectedIndex = 1
                }
            }
        }
    }()
    private lazy var agreementView: SFSignInAgreementView = {
        return SFSignInAgreementView()
    }()
    private lazy var signInBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = R.color.theme()
            view.setTitleColor(R.color.whiteAlways(), for: .normal)
            view.setTitle(R.string.localizable.user_sign_in(), for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    private lazy var infoLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 8, weight: .regular)
            view.textColor = R.color.subtitle()
            view.text = String(format: "V%@(%@)", SFApp.version, SFApp.build)
            view.textAlignment = .center
        }
    }()
    
    private func customUI() {
        scrollView.contentView.addSubview(logoImgView)
        scrollView.contentView.addSubview(nameLabel)
        scrollView.contentView.addSubview(slogenLabel)
        scrollView.contentView.addSubview(modeView)
        scrollView.contentView.addSubview(contentView)
        scrollView.contentView.addSubview(agreementView)
        scrollView.contentView.addSubview(signInBtn)
        scrollView.contentView.addSubview(infoLabel)
        
        logoImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
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
        modeView.snp.makeConstraints { make in
            make.top.equalTo(slogenLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(modeView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        agreementView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(30)
            make.trailing.greaterThanOrEqualToSuperview().offset(-30)
        }
        signInBtn.snp.makeConstraints { make in
            make.top.equalTo(agreementView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(signInBtn.snp.bottom).offset(90)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
}
