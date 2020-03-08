//
//  CreatePostController.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CreatePostController: UIViewController {
    
    @IBOutlet var photoNameTextField: UITextField!
    
    @IBOutlet var photoDescriptionTextView: UITextView!
    
    @IBOutlet var photoImageView: UIImageView!
        
    @IBOutlet var postButton: UIBarButtonItem!
    
    private let dbService = DatabaseService()
    
    private let storageService = StorageService()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(showPhotoOptions))
        return gesture
    }()
    
    private var selectedImage: UIImage? {
        didSet {
            photoImageView.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(longPressGesture)
        photoDescriptionTextView.delegate = self
        photoDescriptionTextView.layer.borderWidth = 1
        photoDescriptionTextView.layer.borderColor = UIColor.placeholderText.cgColor
        photoDescriptionTextView.layer.cornerRadius = 5
    }
    
    @objc private func showPhotoOptions() {
        let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (alertAction) in self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @IBAction func postButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let photoName = photoNameTextField.text, !photoName.isEmpty, let photoDescriptionText = photoDescriptionTextView.text, !photoDescriptionText.isEmpty, let selectedImage = selectedImage else {
            
            showAlert(title: "Missing Fields", message: "All fields are required.")
            return
        }
        
        guard let displayName = Auth.auth().currentUser?.displayName else {
            showAlert(title: "Incomplete Profile", message: "Please go to the profile to complete your Profile")
            return
        }
        
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: photoImageView.bounds)
        
        dbService.createPost(photoTitle: photoName, photoDescription: photoDescriptionText, displayName: displayName) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Bleep", message: "Error: \(error.localizedDescription)")
                }
            case .success(let documentId):
                self?.uploadPhoto(photo: resizedImage, documentId: documentId)
                self?.showAlert(title: "Cool", message: "Your feed's been updated")
                self?.postButton.isEnabled = false
                
//                self?.showAlert(title: "Cool", message: "Your feed's been updated", completion: { (done) in
//                    let feedVC = FeedViewController()
//                    self?.navigationController?.pushViewController(feedVC, animated: true)
//                })
//
//                self?.navigationController?.dismiss(animated: true)
//                self?.dismiss(animated: true)
//                let feedVC = FeedViewController()
//                self?.navigationController?.pushViewController(feedVC, animated: true)
            }
        }

    }
    
    private func uploadPhoto(photo: UIImage, documentId: String) {
        storageService.uploadPhoto(photoId: documentId, image: photo) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error uploading photo", message: "\(error.localizedDescription)")
                }
            case .success(let url):
                self?.updateItemImageURL(url, documentId: documentId)
            }
        }
    }
    
    private func updateItemImageURL(_ url: URL, documentId: String) {
        Firestore.firestore().collection(DatabaseService.postFeedCollection).document(documentId).updateData(["photoURL":url.absoluteString]) { [weak self] (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Fail to update item", message: "\(error.localizedDescription)")
                }
            } else {
                print("all went well")
                DispatchQueue.main.async {
                    self?.dismiss(animated: true)
                }
            }
        }
    }
}

extension CreatePostController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError()
        }
        
        selectedImage = image
        dismiss(animated: true)
    }
}

extension CreatePostController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        photoDescriptionTextView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        photoDescriptionTextView.text = textView.text
    }
}
