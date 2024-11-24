//
//  ClientConnectOptDetailVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: ClientConnectOptDetailVC
class ClientConnectOptDetailVC: OptDetailVC {
    // MARK: var
    var model: ClientConnectOptModel? {
        didSet {
            reconnectView.switchView.setOn(model?.reconnect ?? false, animated: false)
            bridgingView.switchView.setOn(model?.bridging ?? false, animated: false)
            connectionView.switchView.setOn(model?.connection ?? false, animated: false)
            disconnectionView.switchView.setOn(model?.disconnection ?? false, animated: false)
            notificationView.switchView.setOn(model?.notification ?? false, animated: false)
            ancsView.switchView.setOn(model?.ancs ?? false, animated: false)
            delayView.textField.text = model?.delay
        }
    }
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.Main.client_opt_detail_connect
        nameView.subtitleLabel.text = SFText.Main.client_opt_detail_connect_desc
    }
    
    // MARK: ui
    lazy var reconnectView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_connect_reconnect
            view.subtitleLabel.text = SFText.Main.client_opt_detail_connect_reconnect_desc
        }
    }()
    lazy var bridgingView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_connect_bridging
            view.subtitleLabel.text = SFText.Main.client_opt_detail_connect_bridging_desc
        }
    }()
    lazy var connectionView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_connect_connection
            view.subtitleLabel.text = SFText.Main.client_opt_detail_connect_connection_desc
        }
    }()
    lazy var disconnectionView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_connect_disconnection
            view.subtitleLabel.text = SFText.Main.client_opt_detail_connect_disconnection_desc
        }
    }()
    lazy var notificationView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_connect_notification
            view.subtitleLabel.text = SFText.Main.client_opt_detail_connect_notification_desc
        }
    }()
    lazy var ancsView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_connect_ancs
            view.subtitleLabel.text = SFText.Main.client_opt_detail_connect_ancs_desc
        }
    }()
    lazy var delayView: OptStringItemView = {
        return OptStringItemView().then { view in
            view.titleLabel.text = SFText.Main.client_opt_detail_connect_delay
            view.subtitleLabel.text = SFText.Main.client_opt_detail_connect_delay_desc
        }
    }()
   
    override func customUI() {
        super.customUI()
        scrollView.contentView.addSubview(reconnectView)
        scrollView.contentView.addSubview(bridgingView)
        scrollView.contentView.addSubview(connectionView)
        scrollView.contentView.addSubview(disconnectionView)
        scrollView.contentView.addSubview(notificationView)
        scrollView.contentView.addSubview(ancsView)
        scrollView.contentView.addSubview(delayView)
        
        reconnectView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        bridgingView.snp.makeConstraints { make in
            make.top.equalTo(reconnectView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        connectionView.snp.makeConstraints { make in
            make.top.equalTo(bridgingView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        disconnectionView.snp.makeConstraints { make in
            make.top.equalTo(connectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        notificationView.snp.makeConstraints { make in
            make.top.equalTo(disconnectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        ancsView.snp.makeConstraints { make in
            make.top.equalTo(notificationView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        delayView.snp.makeConstraints { make in
            make.top.equalTo(ancsView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
    // MARK: override
    override func editOrSave(_ editEnable: Bool) {
        super.editOrSave(editEnable)
        reconnectView.editEnable = editEnable
        bridgingView.editEnable = editEnable
        connectionView.editEnable = editEnable
        disconnectionView.editEnable = editEnable
        notificationView.editEnable = editEnable
        ancsView.editEnable = editEnable
        delayView.editEnable = editEnable
    }
}

