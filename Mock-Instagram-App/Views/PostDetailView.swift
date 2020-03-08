//
//  PostDetailView.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

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
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description of photo"
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
        label.text = "Date Posted"
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
        setupPostImageViewConstraints()
        setupDescriptionConstraints()
        setupEmailConstraints()
        setupDateConstraints()
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (name) in
            name.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setupPostImageViewConstraints() {
        addSubview(postImageView)
        postImageView.snp.makeConstraints { (image) in
            image.top.equalTo(nameLabel).offset(50)
            image.centerX.equalTo(self.center)
            image.width.equalTo(self).multipliedBy(0.75)
            image.height.equalTo(self).multipliedBy(0.25)
        }
    }
    
    private func setupDescriptionConstraints() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (dLabel) in
            dLabel.top.equalTo(postImageView.snp.bottom).offset(20)
            dLabel.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    private func setupEmailConstraints() {
        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { (email) in
            email.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            email.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    private func setupDateConstraints() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (date) in
            date.top.equalTo(emailLabel.snp.bottom).offset(8)
            date.leading.trailing.equalTo(self).inset(20)
        }
    }


}
