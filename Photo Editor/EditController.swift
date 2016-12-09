//
//  EditController.swift
//  Photo Editor
//
//  Created by Sevan Gregorian on 11/2/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import UIKit
import CoreImage
import CoreFoundation

class EditController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image : UIImage?
    var originalImage : UIImage?
    
    override func viewDidLoad() {
        if let image = image {
            imageView.image = image
            originalImage = image
            //print(CIFilter.filterNames(inCategory: nil))
        }
    }
    @IBAction func rotateLeft(_ sender: Any) {
        if let image = imageView.image{
            imageView.image = RotateImage.rotateLeft(image: image)
        }
    }
    @IBAction func rotateRight(_ sender: Any) {
        if let image = imageView.image{
            imageView.image = RotateImage.rotateRight(image: image)
        }
    }
    @IBAction func mirrorVertical(_ sender: Any) {
        if let image = imageView.image{
            imageView.image = RotateImage.mirror(image: image)
        }
    }
    @IBAction func normalFilter(_ sender: Any) {
        if let image = image {
            imageView.image = image
        }
    }
    @IBAction func xRayFilter(_ sender: Any) {
        if let image = imageView.image{
            imageView.image = image.imageFiltered(withCoreImageFilter: "CIXRay")
        }
    }
    @IBAction func comicFilter(_ sender: Any) {
        if let image = imageView.image{
            imageView.image = image.imageFiltered(withCoreImageFilter: "CIComicEffect")
        }
    }
    @IBAction func twirlFilter(_ sender: Any) {
        if let image = imageView.image{
            imageView.image = image.imageFiltered(withCoreImageFilter: "CITwirlDistortion")
        }
    }
    @IBAction func pixelFilter(_ sender: Any) {
        if let image = imageView.image{
            imageView.image = image.imageFiltered(withCoreImageFilter: "CIPixellate")
        }
    }
    @IBAction func invertFilter(_ sender: Any) {
        if let image = imageView.image{
            imageView.image = image.imageFiltered(withCoreImageFilter: "CIColorInvert")
        }
    }
    @IBAction func roundImage(_ sender: Any) {
        if let image = imageView.image{
            imageView.image = image.imageRoundedIntoCircle()
        }
    }
    @IBAction func blueFilter(_ sender: UIButton) {
        if let image = imageView.image {
            var color = ""
            let colorPicker = UIAlertController(title: "Pick a color", message: "", preferredStyle: .actionSheet)
            colorPicker.addAction(UIAlertAction(title: "Red", style: .default, handler: { (action) in
                color = "red"
                self.imageView.image = image.colorFilter(image: image, color: color)
            }))
            colorPicker.addAction(UIAlertAction(title: "Blue", style: .default, handler: { (action) in
                color = "blue"
                self.imageView.image = image.colorFilter(image: image, color: color)
            }))
            colorPicker.addAction(UIAlertAction(title: "Yellow", style: .default, handler: { (action) in
                color = "yellow"
                self.imageView.image = image.colorFilter(image: image, color: color)
            }))
            colorPicker.addAction(UIAlertAction(title: "Green", style: .default, handler: { (action) in
                color = "green"
                self.imageView.image = image.colorFilter(image: image, color: color)
            }))
            colorPicker.addAction(UIAlertAction(title: "Pink", style: .default, handler: { (action) in
                color = "pink"
                self.imageView.image = image.colorFilter(image: image, color: color)
            }))
            colorPicker.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            present(colorPicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your edited image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
}
