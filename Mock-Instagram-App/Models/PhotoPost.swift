//
//  PhotoPost.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation

struct PhotoPost {
    let photoTitle: String
    let photoDescription: String
    let photoId: String
    let postDate: Date
    let postersName: String
    let postersId: String
    let photoURL: String
}

extension PhotoPost {
    init(_ dictionary: [String: Any]) {
        self.photoTitle = dictionary["photoTitle"] as? String ?? "No Photo Title"
        self.photoDescription = dictionary["photoDescription"] as? String ?? "No Description"
        self.photoId = dictionary["photoId"] as? String ?? "No Photo Id"
        self.postDate = dictionary["postDate"] as? Date ?? Date()
        self.postersName = dictionary["postersName"] as? String ?? "No name"
        self.postersId = dictionary["postersId"] as? String ?? "No posters id"
        self.photoURL = dictionary["photoURL"] as? String ?? "no photo url"
    }
}
