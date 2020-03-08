//
//  ProfileController.swift
//  Mock-Instagram-App
//
//  Created by Kelby Mittan on 3/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

class ProfileController: UIViewController {
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var displayNameTextField: UITextField!
    
    @IBOutlet var emailLabel: UILabel!
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    private var selectedImage: UIImage? {
        didSet {
            profileImage.image = selectedImage
        }
    }
    
    private let storageService = StorageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayNameTextField.delegate = self
        
        updateUI()
    }
    
    private func updateUI() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        emailLabel.text = user.email
        displayNameTextField.text = user.displayName
        profileImage.kf.setImage(with: user.photoURL)
    }
    
    @IBAction func updateProfileButtonPressed(_ sender: UIButton) {
        
        guard let displayName = displayNameTextField.text, !displayName.isEmpty, let selectedImage = selectedImage else {
            print("missing fields")
            return
        }
        
        guard let user = Auth.auth().currentUser else { return }
        
 
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: profileImage.bounds)
        
        print("original image size: \(selectedImage.size)")
        print("resized image size: \(resizedImage)")
        
        storageService.uploadPhoto(userId: user.uid, image: resizedImage) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error updating photo", message: "\(error.localizedDescription)")
                }
            case .success(let url):
                let request = Auth.auth().currentUser?.createProfileChangeRequest()
                request?.displayName = displayName
                request?.photoURL = url
                request?.commitChanges(completion: { [unowned self] (error) in
                    if let error = error {
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Error Updating Profile", message: "Error: \(error.localizedDescription)")
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            self?.showAlert(title: "That's What's Up", message: "Your profile has been updated.")
                        }
                    }
                    
                })
            }
        }
        
    }
    
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Choose Photo Otion", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: nil)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { alertAction in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(storyboardName: "Login", viewControllerId: "LoginViewController")
        } catch {
            DispatchQueue.main.async {
                self.showAlert(title: "Error Signing Out", message: "\(error.localizedDescription)")
            }
        }
    }
    
}

extension ProfileController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        selectedImage = image
        dismiss(animated: true)
    }
}
