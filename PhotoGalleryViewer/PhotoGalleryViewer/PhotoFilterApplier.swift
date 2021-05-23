//
//  PhotoFilterApplier.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 21.05.2021.
//

import UIKit

class PhotoFilterApplier: PhotoFilterApplierProtocol {
  private let context = CIContext(options: nil)
  
  enum Error: Swift.Error {
    case failedToGeneratePNGData,
         failedToCreateFilterWithAGivenName(name: String),
         failedToApplyFilter
  }
  
  func applySepia(to image: UIImage, completion: @escaping ((Result<UIImage, Swift.Error>) -> Void)) {
    guard let data = image.pngData() else {
      completion(.failure(Error.failedToGeneratePNGData))
      return
    }
    let inputImage = CIImage(data: data)
    
    let filterName = "CISepiaTone"
    guard let filter = CIFilter(name: filterName) else {
      completion(.failure(Error.failedToCreateFilterWithAGivenName(name: filterName)))
      return
    }
    filter.setValue(inputImage, forKey: kCIInputImageKey)
    filter.setValue(0.8, forKey: kCIInputIntensityKey)
        
    guard let outputImage = filter.outputImage else {
      completion(.failure(Error.failedToApplyFilter))
      return
    }
    completion(.success(UIImage(ciImage: outputImage)))
  }
}
