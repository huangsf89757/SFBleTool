//
//  SFCMSearchView.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/7.
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


// MARK: - SFCMSearchView
class SFCMSearchView: SFView {
    // MARK: block
    var searchDidChangedBlock: ((SFCMSearchModel?)->())?
    
    // MARK: data
    var model: SFCMSearchModel? {
        didSet {
            textField.text = model?.keyword
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.background()
        customUI()
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = rect.height / 2.0
        layer.borderColor = R.color.placeholder()?.cgColor
        layer.borderWidth = 1
    }
    
    // MARK: ui
    private lazy var searchImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.com.search()
        }
    }()
    private lazy var textField: SFTextField = {
        return SFTextField().then { view in
            view.tintColor = R.color.theme()
            view.textColor = R.color.title()
            view.placeholderColor = R.color.placeholder()
            view.placeholder = R.string.localizable.central_search_ph()
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
extension SFCMSearchView {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        model?.keyword = textField.text
        searchDidChangedBlock?(model)
    }
}

// MARK: - UITextFieldDelegate
extension SFCMSearchView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
