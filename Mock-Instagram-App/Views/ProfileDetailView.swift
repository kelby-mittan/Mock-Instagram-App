//
//  ProfileDetailView.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import SnapKit

class PostDetailView: UIView {

    public lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo.fill")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = iv.frame.size.height/2
        return iv
    }()
    
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Display Name Label"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    public lazy var photoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Post Description"
        label.numberOfLines = 3
        return label
    }()
    
    public lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email@blank.com"
        return label
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "post date: "
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
        setupNameLabel()
        setupImageConstraints()
        setupPhotoDescriptionLabelConstraints()
        setupEmailConstraints()
        setupDateLabelConstraints()
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (name) in
            name.top.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    private func setupImageConstraints() {
        addSubview(postImageView)
        postImageView.snp.makeConstraints { (image) in
            image.top.equalTo(nameLabel).inset(60)
            image.centerX.equalTo(self.center)
            image.width.equalTo(self).multipliedBy(0.75)
            image.height.equalTo(self).multipliedBy(0.25)
        }
    }
    
    private func setupPhotoDescriptionLabelConstraints() {
        addSubview(photoDescriptionLabel)
        photoDescriptionLabel.snp.makeConstraints { (description) in
            description.top.equalTo(postImageView.snp.bottom).offset(20)
            description.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    private func setupEmailConstraints() {
        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { (email) in
            email.top.equalTo(photoDescriptionLabel.snp.bottom).offset(8)
            email.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    private func setupDateLabelConstraints() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (date) in
            date.top.equalTo(emailLabel.snp.bottom).offset(8)
            date.leading.trailing.equalTo(self).inset(20)
        }
    }

}
