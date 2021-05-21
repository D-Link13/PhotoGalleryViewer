//
//  PhotoGallery.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 21.05.2021.
//

import UIKit
import Photos

class PhotoGallery: PhotoGalleryPresenter {
  private var fetchResult: PHFetchResult<PHAsset>!
  private let imageManager = PHCachingImageManager()
  
  func fetchAssets() {
    if fetchResult == nil {
      let allPhotosOptions = PHFetchOptions()
      allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
      fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
    }
  }
  
  func numberOfAssets() -> Int {
    return fetchResult.count
  }
  
  func localIdentifierForAsset(at indexPath: IndexPath) -> String {
    return fetchResult.object(at: indexPath.item).localIdentifier
  }
  
  func requestCachedPhotoAsset(at indexPath: IndexPath, targetSize: CGSize, resultHandler: @escaping (UIImage?) -> Void) {
    let asset = fetchResult.object(at: indexPath.item)
    imageManager.requestImage(for: asset,
                              targetSize: targetSize,
                              contentMode: .aspectFit,
                              options: nil) { image, _ in
      resultHandler(image)
    }
  }
}
