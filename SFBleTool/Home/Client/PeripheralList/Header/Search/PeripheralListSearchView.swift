//
//  PeripheralListSearchView.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/7.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Server
import SFLogger


// MARK: - PeripheralListSearchView
class PeripheralListSearchView: SFView {
    // MARK: block
    var searchDidChangedBlock: ((PeripheralListSearchModel?)->())?
    
    // MARK: data
    var model: PeripheralListSearchModel? {
        didSet {
            textField.text = model?.keyword
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SFColor.UI.content
        customUI()
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = rect.height / 2.0
        layer.borderColor = SFColor.UI.placeholder?.cgColor
        layer.borderWidth = 1
    }
    
    // MARK: ui
    private lazy var searchImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = SFImage.UI.Com.search
        }
    }()
    private lazy var textField: SFTextField = {
        return SFTextField().then { view in
            view.tintColor = SFColor.UI.theme
            view.textColor = SFColor.UI.title
            view.placeholderColor = SFColor.UI.placeholder
            view.placeholder = SFText.Main.peripheral_list_search_hint
            view.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            view.delegate = self
        }
    }()
    private func customUI() {
        addSubview(searchImgView)
        addSubview(textField)
        
        searchImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(searchImgView.snp.trailing).offset(8)
        }
    }
}

// MARK: - action
extension PeripheralListSearchView {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        model?.keyword = textField.text
        searchDidChangedBlock?(model)
    }
}

// MARK: - UITextFieldDelegate
extension PeripheralListSearchView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
