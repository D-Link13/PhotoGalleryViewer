//
//  UIImage+Extensions.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 21.05.2021.
//

import UIKit

extension UIImage {
  func applyingSepiaFilter() -> UIImage? {
    guard let data = self.pngData() else { return nil }
    let inputImage = CIImage(data: data)
        
    let context = CIContext(options: nil)
        
    guard let filter = CIFilter(name: "CISepiaTone") else { return nil }
    filter.setValue(inputImage, forKey: kCIInputImageKey)
    filter.setValue(0.8, forKey: "inputIntensity")
        
    guard
      let outputImage = filter.outputImage,
      let outImage = context.createCGImage(outputImage, from: outputImage.extent)
    else {
      return nil
    }
    return UIImage(cgImage: outImage)
  }
}
