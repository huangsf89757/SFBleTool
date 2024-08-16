//
//  SFCMPeripheralAdvDetailVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/14.
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


// MARK: - SFCMPeripheralAdvDetailVC
class SFCMPeripheralAdvDetailVC: SFScrollViewController {
    // MARK: var
    var changeNavTitleBlock: ((String?)->())?
    
    private lazy var titleView: SFCMPeripheralDetailTitleView = {
        return SFCMPeripheralDetailTitleView().then { view in
            view.titleLabel.text = R.string.localizable.central_bar_adv()
        }
    }()
    
    
    // 数据源
    var localNameModel = SFCMPeripheralAdvItemModel(icon: R.image.adv.localName(),
                                                    title: R.string.localizable.central_adv_title_localName(),
                                                    subtitle: R.string.localizable.central_adv_subtitle_localName(),
                                                    key: R.string.localizable.central_adv_key_localName(),
                                                    value: nil)
    var manufacturerModel = SFCMPeripheralAdvItemModel(icon: R.image.adv.manufacturer(), 
                                                       title: R.string.localizable.central_adv_title_manufacturer(),
                                                       subtitle: R.string.localizable.central_adv_subtitle_manufacturer(),
                                                       key: R.string.localizable.central_adv_key_manufacturer(),
                                                       value: nil)
    var specificServiceModel = SFCMPeripheralAdvItemModel(icon: R.image.adv.service(), 
                                                          title: R.string.localizable.central_adv_title_specificService(),
                                                          subtitle: R.string.localizable.central_adv_subtitle_specificService(),
                                                          key: R.string.localizable.central_adv_key_specificService(),
                                                          value: nil)
    var serviceUuidModel = SFCMPeripheralAdvItemModel(icon: R.image.adv.uuid(), 
                                                      title: R.string.localizable.central_adv_title_serviceUuid(),
                                                      subtitle: R.string.localizable.central_adv_subtitle_serviceUuid(),
                                                      key: R.string.localizable.central_adv_key_serviceUuid(),
                                                      value: nil)
    var overflowUuidModel = SFCMPeripheralAdvItemModel(icon: R.image.adv.uuid(), 
                                                       title: R.string.localizable.central_adv_title_overflowUuid(),
                                                       subtitle: R.string.localizable.central_adv_subtitle_overflowUuid(),
                                                       key: R.string.localizable.central_adv_key_overflowUuid(),
                                                       value: nil)
    var txPowerModel = SFCMPeripheralAdvItemModel(icon: R.image.adv.power(), 
                                                  title: R.string.localizable.central_adv_title_txPower(),
                                                  subtitle: R.string.localizable.central_adv_subtitle_txPower(),
                                                  key: R.string.localizable.central_adv_key_txPower(),
                                                  value: nil)
    var connectableModel = SFCMPeripheralAdvItemModel(icon: R.image.adv.connectable(), 
                                                      title: R.string.localizable.central_adv_title_connectable(),
                                                      subtitle: R.string.localizable.central_adv_subtitle_connectable(),
                                                      key: R.string.localizable.central_adv_key_connectable(),
                                                      value: nil)
    var solicitedUuidModel = SFCMPeripheralAdvItemModel(icon: R.image.adv.uuid(), 
                                                        title: R.string.localizable.central_adv_title_solicitedUuid(),
                                                        subtitle: R.string.localizable.central_adv_subtitle_solicitedUuid(),
                                                        key: R.string.localizable.central_adv_key_solicitedUuid(),
                                                        value: nil)
    var models: [SFCMPeripheralAdvItemModel] {
        return [localNameModel, manufacturerModel, specificServiceModel, serviceUuidModel, overflowUuidModel, txPowerModel, connectableModel, solicitedUuidModel]
    }
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customLayoutOfAdvDetailVC()
        scrollView.delegate = self
    }
    
    // MARK: ui
    private func customLayoutOfAdvDetailVC() {
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        var lastItemView: SFCMPeripheralAdvItemView?
        for i in 0..<models.count {
            let model = models[i]
            let itemView = SFCMPeripheralAdvItemView()
            itemView.model = model
            contentView.addSubview(itemView)
            itemView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                if let lastItemView = lastItemView {
                    make.top.equalTo(lastItemView.snp.bottom)
                } else {
                    make.top.equalTo(titleView.snp.bottom)
                }
                if i == models.count - 1 {
                    make.bottom.equalToSuperview().offset(-100)
                }
                lastItemView = itemView
            }
        }
    }
    
}

extension SFCMPeripheralAdvDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY >= 60 {
            changeNavTitleBlock?(R.string.localizable.central_bar_adv())
        } else {
            changeNavTitleBlock?(nil)
        }
    }
}
