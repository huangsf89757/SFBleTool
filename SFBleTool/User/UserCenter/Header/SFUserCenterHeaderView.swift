//
//  SFUserCenterHeaderView.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/2.
//

// UI
import SFUI
// Server
import SFLogger


// MARK: - SFUserCenterHeaderView
class SFUserCenterHeaderView: SFView {
    // MARK: data
    var model: SFUserModel? {
        didSet {
            guard let model = model else { return }
            if let avatarUrl = model.avatarUrl {
                
            } else {
                avatarImgView.image = R.image.user.user()
            }
            nameLabel.text = model.nickname
            
        }
    }
    
    // MARK: ui
    private lazy var bgImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFill
        }
    }()
    private lazy var avatarImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = R.image.user.user()
        }
    }()
    private lazy var nameView: SFView = {
        return SFView()
    }()
    private lazy var genderImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
//            view.image = R.image.
        }
    }()
    private lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }()
    
    private func customUI() {
        addSubview(bgImgView)
        addSubview(avatarImgView)
        addSubview(nameView)
        nameView.addSubview(nameLabel)
        nameView.addSubview(genderImgView)
        
    }
    
}

