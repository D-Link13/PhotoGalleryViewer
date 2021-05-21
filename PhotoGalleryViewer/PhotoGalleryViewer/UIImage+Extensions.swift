//
//  UIImage+Extensions.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 21.05.2021.
//

import UIKit

typealias PhotoFilterApplier = ((UIImage, @escaping (UIImage?) -> Void) -> Void)

extension UIImage {
  static func applyingSepiaFilter(forImage image: UIImage, completionHandler: @escaping (UIImage?) -> Void) {
    guard let data = image.pngData() else {
      completionHandler(nil)
      return
    }
    let inputImage = CIImage(data: data)
        
    let context = CIContext(options: nil)
        
    guard let filter = CIFilter(name: "CISepiaTone") else {
      completionHandler(nil)
      return
    }
    filter.setValue(inputImage, forKey: kCIInputImageKey)
    filter.setValue(0.8, forKey: "inputIntensity")
        
    guard
      let outputImage = filter.outputImage,
      let outImage = context.createCGImage(outputImage, from: outputImage.extent)
    else {
      completionHandler(nil)
      return
    }
    completionHandler(UIImage(cgImage: outImage))
  }
}
