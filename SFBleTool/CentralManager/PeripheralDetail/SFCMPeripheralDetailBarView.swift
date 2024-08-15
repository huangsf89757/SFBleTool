//
//  SFCMPeripheralDetailBarView.swift
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


// MARK: - SFCMPeripheralDetailBarView
class SFCMPeripheralDetailBarView: SFBarView {
    // MARK: life cycle
    init() {
        let titles = [
            R.string.localizable.central_bar_adv(),
            R.string.localizable.central_bar_service(),
            R.string.localizable.central_bar_log(),
        ]
        let imagesNor = [
            R.image.bar.adv.nor(),
            R.image.bar.service.nor(),
            R.image.bar.log.nor(),
        ]
        let imagesSel = [
            R.image.bar.adv.sel(),
            R.image.bar.service.sel(),
            R.image.bar.log.sel(),
        ]
        super.init(titles: titles, imagesNor: imagesNor, imagesSel: imagesSel)
    }
    private override init(titles: [String?], imagesNor: [UIImage?], imagesSel: [UIImage?]) {
        super.init(titles: titles, imagesNor: imagesNor, imagesSel: imagesSel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: override
    override func customShapePath(rect: CGRect) -> UIBezierPath? {
        return UIBezierPath(roundedRect: rect, cornerRadius: 15)
    }
}
