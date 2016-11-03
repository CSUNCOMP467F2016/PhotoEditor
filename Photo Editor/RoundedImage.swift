//
//  RoundedImage.swift
//  Photo Editor
//
//  Created by Vrezh Gulyan on 11/2/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit


extension UIImage {
    /// Returns a new version of the image with the corners rounded to the specified radius.
    public func imageRounded(withCornerRadius radius: CGFloat, divideRadiusByImageScale: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let scaledRadius = divideRadiusByImageScale ? radius / scale : radius
        
        let clippingPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: size), cornerRadius: scaledRadius)
        clippingPath.addClip()
        
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return roundedImage
    }
    
    /// Returns a new version of the image rounded into a circle.
    public func imageRoundedIntoCircle() -> UIImage {
        let radius = min(size.width, size.height) / 2.0
        var squareImage = self
        
        if size.width != size.height {
            let squareDimension = min(size.width, size.height)
            let squareSize = CGSize(width: squareDimension, height: squareDimension)
            squareImage = squareImage.imageAspectScaled(toFill: squareSize)
        }
        
        UIGraphicsBeginImageContextWithOptions(squareImage.size, false, 0.0)
        
        let clippingPath = UIBezierPath(
            roundedRect: CGRect(origin: CGPoint.zero, size: squareImage.size),
            cornerRadius: radius
        )
        
        clippingPath.addClip()
        
        squareImage.draw(in: CGRect(origin: CGPoint.zero, size: squareImage.size))
        
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return roundedImage
    }
}
