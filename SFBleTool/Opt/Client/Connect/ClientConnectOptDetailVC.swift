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
        nameView.subtitleLabel.text = """
                                      Peripheral Connection Options
                                      Keys used to pass options when connecting to a peripheral.
                                      """
    }
    
    // MARK: ui
    lazy var reconnectView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = "EnableAutoReconnect"
            view.subtitleLabel.text = """
                                      CBConnectPeripheralOptionEnableAutoReconnect
                                      A Boolean value that specifies whether the system automatically reconnects with a peripheral.
                                      """
        }
    }()
    lazy var bridgingView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = "TransportBridging"
            view.subtitleLabel.text = """
                                      CBConnectPeripheralOptionEnableTransportBridgingKey
                                      An option to bridge classic Bluetooth technology profiles, if already connected over Bluetooth Low Energy.
                                      """
        }
    }()
    lazy var connectionView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = "NotifyOnConnection"
            view.subtitleLabel.text = """
                                      CBConnectPeripheralOptionNotifyOnConnectionKey
                                      A Boolean value that specifies whether the system should display an alert when connecting a peripheral in the background.
                                      """
        }
    }()
    lazy var disconnectionView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = "NotifyOnDisconnection"
            view.subtitleLabel.text = """
                                      CBConnectPeripheralOptionNotifyOnDisconnectionKey
                                      A Boolean value that specifies whether the system should display an alert when disconnecting a peripheral in the background.
                                      """
        }
    }()
    lazy var notificationView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = "NotifyOnNotification"
            view.subtitleLabel.text = """
                                      CBConnectPeripheralOptionNotifyOnNotificationKey
                                      A Boolean value that specifies whether the system should display an alert for any notification sent by a peripheral.
                                      """
        }
    }()
    lazy var ancsView: OptBoolItemView = {
        return OptBoolItemView().then { view in
            view.titleLabel.text = "RequiresANCS"
            view.subtitleLabel.text = """
                                      CBConnectPeripheralOptionRequiresANCS
                                      An option to require Apple Notification Center Service (ANCS) when connecting a device.
                                      """
        }
    }()
    lazy var delayView: OptStringItemView = {
        return OptStringItemView().then { view in
            view.titleLabel.text = "StartDelay"
            view.subtitleLabel.text = """
                                      CBConnectPeripheralOptionStartDelayKey
                                      An option that indicates a delay before the system makes a connection.
                                      """
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
}

