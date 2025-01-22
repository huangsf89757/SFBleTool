//
//  OptAddCell.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/23.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

class OptAddCell: SFTableViewCardCell {
    
    
    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        cardInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
//        cardJoin = false
        customUI()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath(roundedRect: cardView.bounds, cornerRadius: 10)
        shapeLayer.path = path.cgPath
    }
        
    // MARK: ui
    private lazy var shapeLayer: CAShapeLayer = {
        return CAShapeLayer().then { layer in
            layer.strokeColor = SFColor.UI.theme?.cgColor
            layer.lineWidth = 2
            layer.lineDashPattern = [6, 3]
            layer.fillColor = nil
        }
    }()
    private lazy var addBtn: SFButton = {
        return SFButton().then { view in
            view.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
            view.setTitleColor(SFColor.UI.theme, for: .normal)
            view.setTitle(SFText.Main.opt_list_new, for: .normal)
            view.setImage(SFImage.UI.Com.add, for: .normal)
            view.isUserInteractionEnabled = false
        }
    }()
   
    private func customUI() {
       cardView.layer.addSublayer(shapeLayer)
       cardView.addSubview(addBtn)
       addBtn.snp.makeConstraints { make in
           make.top.equalToSuperview().offset(10)
           make.leading.equalToSuperview().offset(10)
           make.trailing.equalToSuperview().offset(-10)
           make.bottom.equalToSuperview().offset(-10)
           make.height.equalTo(40)
       }
   }
}

