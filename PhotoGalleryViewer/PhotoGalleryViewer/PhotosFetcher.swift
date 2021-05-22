//
//  PhotosFetcher.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 21.05.2021.
//

import UIKit
import Photos

class PhotosFetcher: PhotosFetcherProtocol {
  private var fetchResult: PHFetchResult<PHAsset>?
  private lazy var imageManager = PHCachingImageManager()
  
  var isAbleToFetch: Bool {
    switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
    case .authorized, .limited: return true
    default: return false
    }
  }
  
  func requestAuthorization(completion: @escaping (Bool) -> Void) {
    PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
      DispatchQueue.main.async {
        switch status {
        case .authorized, .limited: completion(true)
        default: completion(false)
        }
      }
    }
  }
  
  func fetchAssets() {
    guard isAbleToFetch else { return }
    if fetchResult == nil {
      let allPhotosOptions = PHFetchOptions()
      allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
      fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
    }
  }
  
  func numberOfAssets() -> Int {
    return fetchResult?.count ?? 0
  }
  
  func localIdentifierForAsset(at indexPath: IndexPath) -> String? {
    return fetchResult?
      .object(at: indexPath.item)
      .localIdentifier
  }
  
  func requestCachedImage(at indexPath: IndexPath, targetSize: CGSize, resultHandler: @escaping (UIImage?) -> Void) {
    guard let asset = fetchResult?.object(at: indexPath.item) else {
      resultHandler(nil)
      return
    }
    imageManager.requestImage(for: asset,
                              targetSize: targetSize,
                              contentMode: .aspectFit,
                              options: nil) { image, _ in
      resultHandler(image)
    }
  }
}
