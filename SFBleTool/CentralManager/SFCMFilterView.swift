//
//  SFCMFilterView.swift
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
// Third
import WSTagsField


// MARK: - SFCMFilterView
class SFCMFilterView: SFPopView {
    // MARK: var
    var baseY: CGFloat? {
        didSet {
            if let baseY = baseY {
                let rect = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: baseY))
                maskConfigeration.hollowPath = UIBezierPath(rect: rect)
            } else {
                maskConfigeration.hollowPath = nil
            }
        }
    }
    
    private lazy var uuidTitleView: SFCMFilterView.TitleView = {
        return TitleView().then { view in
            view.titleLabel.text = R.string.localizable.central_filter_uuid()
        }
    }()
    private lazy var uuidTagsField: WSTagsField = {
        return WSTagsField().then { view in
            view.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
            view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            view.spaceBetweenLines = 5.0
            view.spaceBetweenTags = 10.0
            view.font = .systemFont(ofSize: 12.0)
            view.backgroundColor = .clear
            view.tintColor = R.color.container()
            view.textColor = R.color.title()
            view.selectedColor = R.color.primary()
            view.selectedTextColor = R.color.white()
            view.delimiter = ","
            view.isDelimiterVisible = true
            view.placeholderColor = R.color.placeholder()
            view.placeholderAlwaysVisible = true
            view.keyboardAppearance = .dark
            view.textField.returnKeyType = .next
            view.acceptTagOption = .space
            view.shouldTokenizeAfterResigningFirstResponder = true

            // Events
            view.onDidAddTag = { field, tag in
                print("DidAddTag", tag.text)
            }

            view.onDidRemoveTag = { field, tag in
                print("DidRemoveTag", tag.text)
            }

            view.onDidChangeText = { _, text in
                print("DidChangeText")
            }

            view.onDidChangeHeightTo = { _, height in
                print("HeightTo", height)
            }

            view.onValidateTag = { tag, tags in
                // custom validations, called before tag is added to tags list
                return tag.text != "#" && !tags.contains(where: { $0.text.uppercased() == tag.text.uppercased() })
            }
        }
    }()
    private lazy var rssiTitleView: SFCMFilterView.TitleView = {
        return TitleView().then { view in
            view.titleLabel.text = R.string.localizable.central_filter_RSSI()
        }
    }()
    private lazy var rssiRangeView: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.placeholder()
        }
    }()
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isCustomShape = true
        shapeLayer.fillColor = R.color.background()?.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 20)
        
        customLayoutOfFilterView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: override
    override func customLayout() {
        var y: CGFloat = 0
        if let baseY = baseY {
            y = baseY
        }
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(y)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    override func customShapePath(rect: CGRect) -> UIBezierPath? {
        return UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
    }
    override func show(stay duration: TimeInterval? = nil, showAnimation: CAAnimation? = nil, dismissAnimation: CAAnimation? = nil, topLevel: Bool = true) {
        super.show(stay: duration, 
                   showAnimation: showAnimationOfTranslation(from: .height(false), duration: 0.24),
                   dismissAnimation: dismissAnimation,
                   topLevel: topLevel)
    }
    override func dismiss(animation: CAAnimation? = nil) {
        super.dismiss(animation: dismissAnimationOfTranslation(to: .height(false), duration: 0.24))
    }
    
    // MARK: ui
    private func customLayoutOfFilterView() {
        addSubview(uuidTitleView)
        addSubview(uuidTagsField)
        addSubview(rssiTitleView)
        addSubview(rssiRangeView)
        
        uuidTitleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        uuidTagsField.snp.makeConstraints { make in
            make.top.equalTo(uuidTitleView.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(80)
        }
        rssiTitleView.snp.makeConstraints { make in
            make.top.equalTo(uuidTagsField.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        rssiRangeView.snp.makeConstraints { make in
            make.top.equalTo(rssiTitleView.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}


// MARK: - click
extension SFCMFilterView {
    @objc private func uuidTipBtnClicked() {
        
    }
    
    @objc private func rssiTipBtnClicked() {
        
    }
}


// MARK: - TitleView
extension SFCMFilterView {
    class TitleView: SFView {
        // MARK: var
        fileprivate lazy var indicatorView: SFView = {
            return SFView().then { view in
                view.backgroundColor = R.color.primary()
                view.layer.cornerRadius = 2
                view.layer.masksToBounds = true
            }
        }()
        fileprivate lazy var titleLabel: SFLabel = {
            return SFLabel().then { view in
                view.font = .systemFont(ofSize: 17, weight: .bold)
                view.textColor = R.color.title()
            }
        }()
        fileprivate lazy var tipBtn: SFButton = {
            return SFButton().then { view in
                let image = R.image.com.tip()?.sf.resize(to: CGSize(width: 15, height: 15)).withTintColor(R.color.placeholder() ?? .gray)
                view.setImage(image, for: .normal)
                view.addTarget(self, action: #selector(uuidTipBtnClicked), for: .touchUpInside)
            }
        }()
        
        // MARK: life cycle
        override init(frame: CGRect) {
            super.init(frame: frame)
            customLayoutOfTitleView()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: ui
        private func customLayoutOfTitleView() {
            addSubview(indicatorView)
            addSubview(titleLabel)
            addSubview(tipBtn)
            
            indicatorView.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel)
                make.leading.equalToSuperview().offset(10)
                make.size.equalTo(CGSize(width: 4, height: 15))
            }
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.leading.equalTo(indicatorView.snp.trailing).offset(6)
                make.bottom.equalToSuperview().offset(-10)
                make.height.greaterThanOrEqualTo(20)
            }
            tipBtn.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel)
                make.leading.equalTo(titleLabel.snp.trailing).offset(0)
                make.size.equalTo(CGSize(width: 40, height: 40))
                make.trailing.lessThanOrEqualToSuperview().offset(-10)
            }
            
        }
    }
}
