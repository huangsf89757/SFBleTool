//
//  SFRssiView.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/8.
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


// MARK: - SFRssiView
class SFRssiView: SFView {
    // MARK: var
    /*
     信号强度：
     0 : < -90
     1 : < -80
     2 : < -75
     3 : < -70
     4 : < -65
     5 : >= -65
     */
    var rssi: Double? {
        didSet {
            guard let rssi = rssi else {
                rssiLabel.text = ""
                rssiImgView.image = R.image.com.rssi.level0()
                return
            }
            rssiLabel.text = String(format: "%.0f dBm", rssi)
            if rssi < -90 {
                rssiImgView.image = R.image.com.rssi.level0()
            }
            else if rssi < -80 {
                rssiImgView.image = R.image.com.rssi.level1()
            }
            else if rssi < -75 {
                rssiImgView.image = R.image.com.rssi.level2()
            }
            else if rssi < -70 {
                rssiImgView.image = R.image.com.rssi.level3()
            }
            else if rssi < -65 {
                rssiImgView.image = R.image.com.rssi.level4()
            }
            else {
                rssiImgView.image = R.image.com.rssi.level5()
            }
        }
    }
        
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var rssiImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    private lazy var rssiLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 10, weight: .regular)
            view.textColor = R.color.title()
            view.textAlignment = .center
        }
    }()
    private func customUI() {
        addSubview(rssiImgView)
        addSubview(rssiLabel)
        
        rssiImgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.width.equalTo(rssiImgView.snp.height)
        }
        rssiLabel.snp.makeConstraints { make in
            make.top.equalTo(rssiImgView.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(15)
        }
    }
}
