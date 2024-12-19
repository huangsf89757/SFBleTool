//
//  OptDetailNameView.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/19.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

class OptDetailNameView: SFView {
    // MARK: data
    var model: OptModel? {
        didSet {
            guard let model = model else { return }
            textField.text = model.name
        }
    }
    var isEdit = false {
        didSet {
            textField.rightViewMode = isEdit ? .unlessEditing : .never
            textField.isUserInteractionEnabled = isEdit
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    lazy var textField: SFTextField = {
        return SFTextField().then { view in
            view.placeholder = SFText.Main.opt_detail_name
            view.rightViewMode = .unlessEditing
            view.rightView = SFImageView().then({ view in
                view.contentMode = .scaleAspectFit
                view.image = SFImage.UI.Com.edit
                view.alpha = 0.5
                view.frame = CGRect(origin: .zero, size: CGSize(width: 18, height: 18))
            })
            view.font = .systemFont(ofSize: 20, weight: .bold)
            view.textColor = SFColor.UI.title
            view.textAlignment = .center
            view.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
            view.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
    }()
    private func customUI() {
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Action
extension OptDetailNameView {
    @objc private func textFieldAction(_ sender: SFTextField) {
        model?.name = sender.text
    }
}
