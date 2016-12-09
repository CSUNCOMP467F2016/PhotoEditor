//
//  FilteredImage.swift
//  Photo Editor
//
//  Created by Khajag Basmajian on 11/2/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

extension UIImage {
    /// Returns a new version of the image using a CoreImage filter with the specified name and parameters.
    public func imageFiltered(withCoreImageFilter name: String, parameters: [String: Any]? = nil) -> UIImage? {
        var image: CoreImage.CIImage? = ciImage
        
        if image == nil, let CGImage = self.cgImage {
            image = CoreImage.CIImage(cgImage: CGImage)
        }
        
        guard let coreImage = image else { return nil }
        
        let context = CIContext(options: [kCIContextPriorityRequestLow: true])
        
        var parameters: [String: Any] = parameters ?? [:]
        parameters[kCIInputImageKey] = coreImage
        
        guard let filter = CIFilter(name: name, withInputParameters: parameters) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        let cgImageRef = context.createCGImage(outputImage, from: outputImage.extent)
        
        return UIImage(cgImage: cgImageRef!, scale: scale, orientation: imageOrientation)
    }
    
    public func colorFilter(image : UIImage, color : String) -> UIImage {
        var newImage = image
        
        let blueKernelString =
            "kernel vec4 chromaKey( __sample s) { \n" +
                "  vec4 newPixel = s.rgba;" +
                "  newPixel[0] = 0.0;" +
                "  newPixel[2] = newPixel[2] / 1.5;" +
                "  return newPixel;\n" +
        "}"
        let pinkKernelString =
            "kernel vec4 chromaKey( __sample s) { \n" +
                "  vec4 newPixel = s.rgba;" +
                "  newPixel[0] = newPixel[0] / 1.5;" +
                "  newPixel[1] = 0.0;" +
                "  newPixel[2] = newPixel[2] / 1.5;" +
                "  return newPixel;\n" +
        "}"
        let yellowKernelString =
            "kernel vec4 chromaKey( __sample s) { \n" +
                "  vec4 newPixel = s.rgba;" +
                "  newPixel[0] = newPixel[0] / 1.5;" +
                "  newPixel[1] = newPixel[1] / 1.5;" +
                "  newPixel[2] = 0.0;" +
                "  return newPixel;\n" +
        "}"
        let redKernelString =
            "kernel vec4 chromaKey( __sample s) { \n" +
                "  vec4 newPixel = s.rgba;" +
                "  newPixel[0] = newPixel[0] / 1.5;" +
                "  newPixel[1] = 0.0;" +
                "  newPixel[2] = 0.0;" +
                "  return newPixel;\n" +
        "}"
        let greenKernelString =
            "kernel vec4 chromaKey( __sample s) { \n" +
                "  vec4 newPixel = s.rgba;" +
                "  newPixel[0] = 0.0;" +
                "  newPixel[1] = newPixel[1] / 1.5;" +
                "  newPixel[2] = 0.0;" +
                "  return newPixel;\n" +
        "}"
        func createCustomKernel(color: String) -> CIColorKernel {
            var kernel = ""
            switch(color) {
            case "red":
                kernel = redKernelString
                break
            case "blue":
                kernel = blueKernelString
                break
            case "green":
                kernel = greenKernelString
                break
            case "yellow":
                kernel = yellowKernelString
                break
            case "pink":
                kernel = pinkKernelString
                break
            default:
                kernel = redKernelString
                break
            }

            return CIColorKernel(string: kernel)!
        }
        
        if let ciImage =  CIImage(image: image) {
            let args = [ciImage as AnyObject]
            if let outputImage = createCustomKernel(color: color).apply(withExtent: ciImage.extent, arguments: args) {
                let context = CIContext(options: [kCIContextPriorityRequestLow: true])
                if let cgImageRef = context.createCGImage(outputImage, from: outputImage.extent){
                    newImage =  UIImage(cgImage: cgImageRef)
                }
            }
        }
        
        return newImage
    }
}
