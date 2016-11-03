//
//  RotateImage.swift
//  Photo Editor
//
//  Created by Vrezh Gulyan on 11/3/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import Foundation
import UIKit

class RotateImage {
    
    class func rotateRight(image : UIImage) -> UIImage {
        
            var orientation = UIImageOrientation.up
            switch (image.imageOrientation) {
            case UIImageOrientation.up:
                orientation = UIImageOrientation.right
                break
            case UIImageOrientation.right:
                orientation = UIImageOrientation.down
                break
            case UIImageOrientation.down:
                orientation = UIImageOrientation.left
                break
            case UIImageOrientation.left:
                orientation = UIImageOrientation.up
                break
            default:
                break
            }
            
            return UIImage(cgImage: image.cgImage!, scale: 100.0, orientation: orientation)
    }
    
    class func rotateLeft(image : UIImage) -> UIImage {
        
        var orientation = UIImageOrientation.up
        switch (image.imageOrientation) {
        case UIImageOrientation.up:
            orientation = UIImageOrientation.left
            break
        case UIImageOrientation.left:
            orientation = UIImageOrientation.down
            break
        case UIImageOrientation.down:
            orientation = UIImageOrientation.right
            break
        case UIImageOrientation.right:
            orientation = UIImageOrientation.up
            break
        default:
            break
        }
        return UIImage(cgImage: image.cgImage!, scale: 100.0, orientation: orientation)
    }
    
    class func mirror(image : UIImage) -> UIImage {
        var orientation = image.imageOrientation
        if (orientation == UIImageOrientation.up || orientation == UIImageOrientation.upMirrored){
            orientation = UIImageOrientation.downMirrored
            } else {
            orientation = UIImageOrientation.upMirrored
        }
        return UIImage(cgImage: image.cgImage!, scale: 100.0, orientation: orientation)
    }
}
