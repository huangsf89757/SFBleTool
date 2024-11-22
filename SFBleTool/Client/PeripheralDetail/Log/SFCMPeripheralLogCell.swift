//
//  SFCMPeripheralLogCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/16.
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


// MARK: - SFCMPeripheralLogCell
class SFCMPeripheralLogCell: SFTableViewCell {
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
