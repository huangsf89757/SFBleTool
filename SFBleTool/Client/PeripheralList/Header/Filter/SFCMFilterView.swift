//
//  SFCMFilterView.swift
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
// Third
import WSTagsField
import WARangeSlider


// MARK: - SFCMFilterView
class SFCMFilterView: SFPopView {
    // MARK: block
    var uuidTipBlock: (()->())?
    var rssiTipBlock: (()->())?
    var resetBlock: (()->())?
    var sureBlock: (()->())?
    
    // MARK: var
    
    // MARK: data
    var model: SFCMFilterModel? {
        didSet {
            guard let model = model else { return }
            
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.sf.setCornerAndShadow(radius: 20, fillColor: SFColor.UI.background, shadowColor: SFColor.UI.black, shadowOpacity: 0.3, shadowOffset: CGSize(width: 0, height: 20), shadowRadius: 5)
        customUIOfFilterView()
    }
    
    // MARK: override
    override func customLayout() {
        self.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    override func draw(_ rect: CGRect) {
        self.sf.applyCornerAndShadow()
    }
    override func show(in view: UIView? = nil, stay duration: TimeInterval? = nil, showAnimations: [CAAnimation] = [], dismissAnimations: [CAAnimation] = [], topLevel: Bool = true) {
        let animDuration: TimeInterval = 0.24
        let showAnimationOfTranslation = animationOfTranslation(from: .top, to: .zero, duration: animDuration)
        let showAnimationOfOpacity = animationOfOpacity(from: 0, to: 1, duration: animDuration)
        super.show(in: view, 
                   stay: duration,
                   showAnimations: [showAnimationOfTranslation, showAnimationOfOpacity],
                   dismissAnimations: dismissAnimations,
                   topLevel: topLevel)
    }
    override func dismiss(animations: [CAAnimation] = []) {
        let animDuration: TimeInterval = 0.24
        let dismissAnimationOfTranslation = animationOfTranslation(from: .zero, to: .top, duration: animDuration)
        let dismissAnimationOfOpacity = animationOfOpacity(from: 1, to: 0, duration: animDuration)
        super.dismiss(animations: [dismissAnimationOfTranslation, dismissAnimationOfOpacity])
    }
    
    // MARK: ui
    private lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 18, weight: .bold)
            view.textColor = SFColor.UI.title
            view.textAlignment = .center
//            view.text = R.string.localizable.central_filter_title()
        }
    }()
    private lazy var uuidTitleView: SFCMFilterView.TitleView = {
        return TitleView().then { view in
//            view.titleLabel.text = R.string.localizable.central_filter_uuid()
            view.tipBlock = { [weak self] in
                self?.uuidTipBlock?()
            }
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
            view.tintColor = SFColor.UI.background
            view.textColor = SFColor.UI.title
            view.selectedColor = SFColor.UI.theme
            view.selectedTextColor = SFColor.UI.white
//            view.placeholder = R.string.localizable.central_filter_uuid_ph()
            view.placeholderColor = SFColor.UI.placeholder
            view.placeholderAlwaysVisible = true
            view.textField.returnKeyType = .next
            view.acceptTagOption = [.space, .return]
            view.shouldTokenizeAfterResigningFirstResponder = true
            view.enableScrolling = true

            // Events
            view.onDidAddTag = { field, tag in
                Log.debug("DidAddTag:\(tag.text)")
            }
            view.onDidRemoveTag = { field, tag in
                Log.debug("DidRemoveTag:\(tag.text)")
            }
            view.onDidChangeText = { _, text in
                Log.debug("DidChangeText:\(text ?? "")")
            }
            view.onDidChangeHeightTo = { _, height in
                Log.debug("onDidChangeHeightTo:\(height)")
            }
            view.onValidateTag = { tag, tags in
                // custom validations, called before tag is added to tags list
                return tag.text != "#" && !tags.contains(where: { $0.text.uppercased() == tag.text.uppercased() })
            }
        }
    }()
    private lazy var rssiTitleView: SFCMFilterView.TitleView = {
        return TitleView().then { view in
//            view.titleLabel.text = R.string.localizable.central_filter_RSSI()
            view.tipBlock = { [weak self] in
                self?.rssiTipBlock?()
            }
        }
    }()
    private lazy var rssiRangeView: RangeSlider = {
        return RangeSlider().then { view in
            view.minimumValue = -100
            view.maximumValue = 0
            view.lowerValue = -90
            view.upperValue = -50
            view.trackTintColor = SFColor.UI.placeholder ?? .gray
            view.trackHighlightTintColor = SFColor.UI.theme ?? .blue
            view.thumbTintColor = SFColor.UI.white ?? .white
            view.thumbBorderColor = SFColor.UI.placeholder ?? .gray
            view.thumbBorderWidth = 1
            view.curvaceousness = 1
            view.addTarget(self, action: #selector(rssiRangeValueChanged(_:)), for: .valueChanged)
        }
    }()
    private lazy var resetBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = SFColor.UI.auxiliary
            view.setTitleColor(SFColor.UI.whiteAlways, for: .normal)
            view.layer.cornerRadius = 10
//            view.setTitle(R.string.localizable.central_filter_reset(), for: .normal)
            view.addTarget(self, action: #selector(resetBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var sureBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = SFColor.UI.theme
            view.setTitleColor(SFColor.UI.whiteAlways, for: .normal)
            view.layer.cornerRadius = 10
//            view.setTitle(R.string.localizable.central_filter_sure(), for: .normal)
            view.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
        }
    }()
    private func customUIOfFilterView() {
        addSubview(titleLabel)
        addSubview(uuidTitleView)
        addSubview(uuidTagsField)
        addSubview(rssiTitleView)
        addSubview(rssiRangeView)
        addSubview(resetBtn)
        addSubview(sureBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(SFApp.safeAreaInsets().top + 20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        uuidTitleView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        uuidTagsField.snp.makeConstraints { make in
            make.top.equalTo(uuidTitleView.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(80)
        }
        rssiTitleView.snp.makeConstraints { make in
            make.top.equalTo(uuidTagsField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        rssiRangeView.snp.makeConstraints { make in
            make.top.equalTo(rssiTitleView.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        resetBtn.snp.makeConstraints { make in
            make.top.equalTo(rssiRangeView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        sureBtn.snp.makeConstraints { make in
            make.top.equalTo(resetBtn)
            make.leading.equalTo(resetBtn.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(resetBtn)
            make.width.equalTo(resetBtn)
        }
    }
    
}


// MARK: - action
extension SFCMFilterView {
    @objc private func rssiRangeValueChanged(_ sender: RangeSlider) {
        
    }
    
    /// 点击重置
    @objc private func resetBtnClicked() {
        resetBlock?()
    }
    
    /// 点击确定
    @objc private func sureBtnClicked() {
        sureBlock?()
    }
}


// MARK: - TitleView
extension SFCMFilterView {
    class TitleView: SFView {
        // MARK: block
        fileprivate var tipBlock: (()->())?       
        
        // MARK: life cycle
        override init(frame: CGRect) {
            super.init(frame: frame)
            customUIOfTitleView()
        }
        
        // MARK: ui
        fileprivate lazy var indicatorView: SFView = {
            return SFView().then { view in
                view.backgroundColor = SFColor.UI.theme
                view.layer.cornerRadius = 2
                view.layer.masksToBounds = true
            }
        }()
        fileprivate lazy var titleLabel: SFLabel = {
            return SFLabel().then { view in
                view.font = .systemFont(ofSize: 17, weight: .bold)
                view.textColor = SFColor.UI.title
            }
        }()
        fileprivate lazy var tipBtn: SFButton = {
            return SFButton().then { view in
//                let image = R.image.com.tip()?.sf.resize(to: CGSize(width: 15, height: 15)).withTintColor(SFColor.UI.placeholder ?? .gray)
//                view.setImage(image, for: .normal)
                view.addTarget(self, action: #selector(tipBtnClicked), for: .touchUpInside)
            }
        }()
        private func customUIOfTitleView() {
            addSubview(indicatorView)
            addSubview(titleLabel)
            addSubview(tipBtn)
            
            indicatorView.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel)
                make.leading.equalToSuperview()
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
                make.leading.equalTo(titleLabel.snp.trailing).offset(-5)
                make.size.equalTo(CGSize(width: 40, height: 40))
                make.trailing.lessThanOrEqualToSuperview()
            }
        }
        
        // MARK: func
        @objc private func tipBtnClicked() {
            tipBlock?()
        }
    }
}
