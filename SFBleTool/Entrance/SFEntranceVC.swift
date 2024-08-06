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
class SFEntranceVC: SFViewController {
    // MARK: var
    private lazy var logoImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    private lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
        }
    }()
    private lazy var slogenLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }()
    private lazy var centralEntranceView: SFEntranceView = {
        return SFEntranceView()
    }()
    private lazy var peripheralEntranceView: SFEntranceView = {
        return SFEntranceView()
    }()
    
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customLayoutOfEntranceVC()
    }
    
    // MARK: ui
    private func customLayoutOfEntranceVC() {
        
    }
}

