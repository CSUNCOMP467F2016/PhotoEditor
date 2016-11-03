//
//  EditController.swift
//  Photo Editor
//
//  Created by Vrezh Gulyan on 11/2/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import UIKit
import CoreImage
import CoreFoundation
class EditController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image : UIImage?
    
    override func viewDidLoad() {
        if let image = image {
            
            imageView.image = image
            print(CIFilter.filterNames(inCategory: nil))
            
        }
    }
    
    @IBAction func rotateLeft(_ sender: Any) {
        imageView.image = RotateImage.rotateLeft(image: imageView.image!)
    }
    @IBAction func rotateRight(_ sender: Any) {
        imageView.image = RotateImage.rotateRight(image: imageView.image!)
    }
    @IBAction func mirrorVertical(_ sender: Any) {
        imageView.image = RotateImage.mirror(image: imageView.image!)
    }
    @IBAction func normalFilter(_ sender: Any) {
        imageView.image = image!
    }
    @IBAction func xRayFilter(_ sender: Any) {
        imageView.image = imageView.image?.imageFiltered(withCoreImageFilter: "CIXRay")
    }
    @IBAction func comicFilter(_ sender: Any) {
        imageView.image = imageView.image?.imageFiltered(withCoreImageFilter: "CIComicEffect")
    }
    @IBAction func twirlFilter(_ sender: Any) {
        imageView.image = imageView.image?.imageFiltered(withCoreImageFilter: "CITwirlDistortion")
    }
    @IBAction func pixelFilter(_ sender: Any) {
        imageView.image = imageView.image?.imageFiltered(withCoreImageFilter: "CIPixellate")
    }
    @IBAction func invertFilter(_ sender: Any) {
        imageView.image = imageView.image?.imageFiltered(withCoreImageFilter: "CIColorInvert")
    }
    @IBAction func roundImage(_ sender: Any) {
        imageView.image = imageView.image?.imageRoundedIntoCircle()
    }

}
