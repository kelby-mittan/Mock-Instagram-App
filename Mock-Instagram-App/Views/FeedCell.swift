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
    
    public lazy var displayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.text = "@displayname"
        return label
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
        setupDisplayNameLabelConstraints()
    }
    
    private func setupFeedImageConstraints() {
        addSubview(feedImage)
        feedImage.snp.makeConstraints { (feedImage) in
            feedImage.top.leading.trailing.bottom.equalTo(self)
        }
    }
    
    private func setupDisplayNameLabelConstraints() {
        addSubview(displayNameLabel)
        displayNameLabel.snp.makeConstraints { (displayName) in
            displayName.leading.trailing.equalTo(self).inset(10)
            displayName.bottom.equalTo(self.snp.bottom).inset(10)
        }
    }
    
    public func configureCell(for post: PhotoPost) {
        feedImage.kf.setImage(with: URL(string: post.photoURL))
        displayNameLabel.text = "\(post.postersName)"
    }
}
