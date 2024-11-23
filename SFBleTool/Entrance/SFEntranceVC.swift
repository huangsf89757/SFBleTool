//
//  SFEntranceVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/6.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Business
import SFBusiness
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        colorLayer.frame = view.bounds
    }
    
    // MARK: ui
    private lazy var colorLayer: CAGradientLayer = {
        return CAGradientLayer().then { layer in
            layer.startPoint = CGPoint(x: 1, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
            layer.locations = [0, 1]
            let color: UIColor = SFColor.UI.theme ?? UIColor.green
            layer.colors = [color.cgColor, UIColor.white.cgColor]
        }
    }()
    private lazy var logoView: SFLogoView = {
        return SFLogoView()
    }()
    private lazy var clientOptView: SFEntranceOptView = {
        return SFEntranceOptView().then { view in
            view.tag = 2
            view.titleLabel.text = SFText.Main.entrance_client_title
            view.subtitleLabel.text = SFText.Main.entrance_client_subtitle
            view.tapBlock = {
                [weak self] optView in
                self?.entranceOptViewTaped(optView)
            }
        }
    }()
    private lazy var serverOptView: SFEntranceOptView = {
        return SFEntranceOptView().then { view in
            view.tag = 3
            view.titleLabel.text = SFText.Main.entrance_server_title
            view.subtitleLabel.text = SFText.Main.entrance_server_subtitle
            view.tapBlock = {
                [weak self] optView in
                self?.entranceOptViewTaped(optView)
            }
        }
    }()
    private func customUI() {
        view.layer.insertSublayer(colorLayer, at: 0)
        scrollView.backgroundColor = .clear
        scrollView.contentView.backgroundColor = .clear
        scrollView.contentView.addSubview(logoView)
        scrollView.contentView.addSubview(clientOptView)
        scrollView.contentView.addSubview(serverOptView)
        
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        clientOptView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(80)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        serverOptView.snp.makeConstraints { make in
            make.top.equalTo(clientOptView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.lessThanOrEqualToSuperview().offset(-100)
        }
    }
}

// MARK: action
extension SFEntranceVC {
    private func entranceOptViewTaped(_ sender: SFEntranceOptView) {
        clientOptView.isSelected = (sender === clientOptView)
        serverOptView.isSelected = (sender === serverOptView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.didChooseEntranceOptBlock?(sender.tag)
        }
    }
}
