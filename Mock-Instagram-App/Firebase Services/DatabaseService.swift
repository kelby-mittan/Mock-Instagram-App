//
//  DatabaseService.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
    
    static let postFeedCollection = "posts"
    
    private let db = Firestore.firestore()
    
    public func createPost(photoTitle: String, photoDescription: String, displayName: String, completion: @escaping (Result<String, Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        let documentRef = db.collection(DatabaseService.postFeedCollection).document()
        db.collection(DatabaseService.postFeedCollection).document(documentRef.documentID).setData(["photoTitle":photoTitle ,"photoDescription":photoDescription , "photoId":documentRef.documentID , "postDate":Timestamp(date: Date()) , "postersName":displayName , "postersId": user.uid]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(documentRef.documentID))
            }
            
        }
    }
}
