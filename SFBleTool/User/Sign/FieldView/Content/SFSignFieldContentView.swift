//
//  SFSignFieldContentView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/11.
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

// MARK: - SFSignFieldContentView
class SFSignFieldContentView: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.background()
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}
