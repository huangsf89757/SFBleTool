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
    init() {
        let titles = [
            R.string.localizable.central_detail_item_adv(),
            R.string.localizable.central_detail_item_service(),
            R.string.localizable.central_detail_item_log(),
        ]
        let images = [
            R.image.bar.adv.nor(),
            R.image.bar.service.nor(),
            R.image.bar.log.nor(),
        ]
        let selectedImages = [
            R.image.bar.adv.sel(),
            R.image.bar.service.sel(),
            R.image.bar.log.sel(),
        ]
        super.init(titles: titles, images: images, selectedImages: selectedImages)
    }
    override init(direction: SFSegmentView.Direction = .horizontal, titles: [String?]?, images: [UIImage?]?, selectedImages: [UIImage?]? = nil) {
        super.init(direction: .horizontal, titles: titles, images: images, selectedImages: selectedImages)
        self.sf.setCornerAndShadow(radius: 10, fillColor: SFColor.background, shadowColor: SFColor.black, shadowOpacity: 0.3, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 5)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        self.sf.applyCornerAndShadow()
    }
}
