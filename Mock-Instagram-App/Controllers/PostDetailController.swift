//
//  PostDetailController.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class PostDetailController: UIViewController {
    
    let postDetailView = PostDetailView()
    
    override func loadView() {
        view = postDetailView
    }
    
    public var post: PhotoPost
    
    init(_ post: PhotoPost) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postDetailView.backgroundColor = .systemBackground
        updateUI()
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a" //"EEEE, MMM d, yyyy h:mm a"
        return formatter
    }()

    private func getDateFromString(dateString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
           formatter.formatOptions = [.withDashSeparatorInDate,
                                      .withFullDate,
                                      .withColonSeparatorInTimeZone]
           guard let date = formatter.date(from: dateString) else {
             return nil
           }
           return date
    }
    
    private func updateUI() {
        postDetailView.nameLabel.text = "\(post.postersName)"
        
        guard let url = URL(string: post.photoURL) else {
            return
        }
        postDetailView.postImageView.kf.setImage(with: url)
        postDetailView.postImageView.clipsToBounds = true
        postDetailView.postImageView.layer.cornerRadius = 20
        postDetailView.descriptionLabel.text = "\(post.photoDescription)"
        
        postDetailView.emailLabel.text = ""
        
        postDetailView.dateLabel.text = "\(dateFormatter.string(from: post.postDate))"
        
    }
    
    
}
