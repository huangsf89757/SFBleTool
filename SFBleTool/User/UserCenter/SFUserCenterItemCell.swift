//
//  SFUserCenterItemCell.swift
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


// MARK: - SFUserCenterItemCell
class SFUserCenterItemCell: SFTableViewCell {
    // MARK: ui
    private lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    
    private lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            
        }
    }()
    
    private lazy var detailImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.com.detail()
        }
    }()
    
}
