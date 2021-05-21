//
//  UIImage+Extensions.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 21.05.2021.
//

import UIKit

typealias PhotoFilterApplier = ((UIImage, @escaping (ApplyingFilterResult) -> Void) -> Void)

enum ApplyingFilterResult {
  case success(UIImage)
  case failure(ApplyingFilterError)
}

enum ApplyingFilterError: Error {
  case failedToGeneratePNGData, failedToCreateFilterWithAGivenName, failedToApplyFilter
}

extension UIImage {
  static func applyingSepiaFilter(forImage image: UIImage, completionHandler: @escaping (ApplyingFilterResult) -> Void) {
    guard let data = image.pngData() else {
      completionHandler(.failure(ApplyingFilterError.failedToGeneratePNGData))
      return
    }
    let inputImage = CIImage(data: data)
        
    let context = CIContext(options: nil)
        
    guard let filter = CIFilter(name: "CISepiaTone") else {
      completionHandler(.failure(ApplyingFilterError.failedToCreateFilterWithAGivenName))
      return
    }
    filter.setValue(inputImage, forKey: kCIInputImageKey)
    filter.setValue(0.8, forKey: "inputIntensity")
        
    guard
      let outputImage = filter.outputImage,
      let outImage = context.createCGImage(outputImage, from: outputImage.extent)
    else {
      completionHandler(.failure(ApplyingFilterError.failedToApplyFilter))
      return
    }
    completionHandler(.success(UIImage(cgImage: outImage)))
  }
}
