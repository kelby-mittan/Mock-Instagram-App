//
//  FeedViewController.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "feedCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    @IBAction func addPostButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    

}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            fatalError("could not deque cell")
        }
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .orange
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
        
    }
}
