//
//  FilteredImage.swift
//  Photo Editor
//
//  Created by Vrezh Gulyan on 11/2/16.
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
}
