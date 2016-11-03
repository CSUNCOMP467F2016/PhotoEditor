//
//  EditController.swift
//  Photo Editor
//
//  Created by Vrezh Gulyan on 11/2/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import UIKit

class EditController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image : UIImage?
    
    override func viewDidLoad() {
        if let image = image {
            imageView.image = image
        }
    }
}
