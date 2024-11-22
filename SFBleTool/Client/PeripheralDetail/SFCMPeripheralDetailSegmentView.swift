//
//  SFCMPeripheralDetailSegmentView.swift
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


// MARK: - SFCMPeripheralDetailSegmentView
class SFCMPeripheralDetailSegmentView: SFSegmentView {
    // MARK: life cycle
    convenience init() {
        let titles: [String] = [
//            R.string.localizable.central_detail_item_adv(),
//            R.string.localizable.central_detail_item_service(),
//            R.string.localizable.central_detail_item_log(),
        ]
        self.init(titles: titles, images: nil, selectedImages: nil)
    }
    
    private override init(direction: SFSegmentView.Direction = .horizontal, titles: [String?]?, images: [UIImage?]?, selectedImages: [UIImage?]? = nil) {
        super.init(direction: .horizontal, titles: titles, images: images, selectedImages: selectedImages)
        titleFont = .systemFont(ofSize: 17, weight: .regular)
        selectedTitleFont = .systemFont(ofSize: 17, weight: .bold)
        spaceOfItems = 20
    }
    
}
