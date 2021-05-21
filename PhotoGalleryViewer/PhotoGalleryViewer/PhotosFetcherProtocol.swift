//
//  PhotosFetcherProtocol.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 21.05.2021.
//

import UIKit

protocol PhotosFetcherProtocol {
  func fetchAssets()
  func numberOfAssets() -> Int
  func localIdentifierForAsset(at indexPath: IndexPath) -> String
  func requestCachedImage(at indexPath: IndexPath, targetSize: CGSize, resultHandler: @escaping (UIImage?) -> Void)
}
