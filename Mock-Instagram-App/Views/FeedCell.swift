//
//  FeedCell.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import SnapKit

class FeedCell: UICollectionViewCell {
    
    public lazy var feedImage: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(systemName: "photo.fill")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupFeedImageConstraints()
    }
    
    private func setupFeedImageConstraints() {
        addSubview(feedImage)
        feedImage.snp.makeConstraints { (feedImage) in
            feedImage.top.leading.trailing.bottom.equalTo(self)
        }
    }
}
