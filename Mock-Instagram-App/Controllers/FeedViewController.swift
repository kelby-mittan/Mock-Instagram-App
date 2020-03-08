//
//  FeedViewController.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FeedViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    private var listener: ListenerRegistration?
    
    private var posts = [PhotoPost]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "feedCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadListener()
    }
    
    private func loadListener() {
        listener = Firestore.firestore().collection(DatabaseService.postFeedCollection).addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "\(error.localizedDescription)")
                }
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.map { PhotoPost($0.data()) }
                self?.posts = posts
            }
        })
    }
    
    @IBAction func addPostButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    

}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            fatalError("could not deque cell")
        }
        let post = posts[indexPath.row]
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .orange
        cell.configureCell(for: post)
        return cell
    }
    
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        
        let spacingBetweenItems: CGFloat = 11
        let numberOfItems: CGFloat = 2
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        let itemHeight: CGFloat = maxSize.height * 0.20
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let detailVC = PostDetailController(post)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
