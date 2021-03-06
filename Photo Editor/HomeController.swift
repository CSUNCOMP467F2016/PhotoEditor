//
//  ViewController.swift
//  Photo Editor
//
//  Created by Vrezh Gulyan on 10/20/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import UIKit

class HomeController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self

    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        let cameraActionSheet = UIAlertController(title: "Pick an option below", message: "", preferredStyle: .actionSheet)
        cameraActionSheet.addAction((UIAlertAction(title: "Choose from gallery", style: .default, handler: {
            _ in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.imagePicker, animated: true, completion: nil)
        })))
        cameraActionSheet.addAction((UIAlertAction(title: "Take picture", style: .default, handler: {
            _ in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            
            self.present(self.imagePicker, animated: true, completion: nil)
        })))
        cameraActionSheet.addAction((UIAlertAction(title: "Cancel", style: .destructive, handler: nil )))
        present(cameraActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func editPhoto(_ sender: UIButton) {
        performSegue(withIdentifier: "edit", sender: "any")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            
            editButton.isHidden = false
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let editController = segue.destination as? EditController
        
            editController?.image = imageView.image
        }

    }
}

