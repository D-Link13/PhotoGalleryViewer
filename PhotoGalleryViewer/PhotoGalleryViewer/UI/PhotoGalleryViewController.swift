//
//  PhotoGalleryViewController.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 20.05.2021.
//

import UIKit

class PhotoGalleryViewController: UITableViewController {
  private lazy var photosFetcher: PhotosFetcherProtocol = PhotosFetcher()
  private lazy var photoFilterApplier: PhotoFilterApplier = UIImage.applyingSepiaFilter
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if photosFetcher.isAbleToFetch {
      photosFetcher.fetchAssets()
    } else {
      photosFetcher.requestAuthorization { [weak self] isAbleToFetch in
        if isAbleToFetch {
          self?.photosFetcher.fetchAssets()
          self?.tableView.reloadData()
        } else {
          self?.present(UIAlertController.settings(), animated: true)
        }
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photosFetcher.numberOfAssets()
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PhotoImageTableViewCell.identifier, for: indexPath) as! PhotoImageTableViewCell
    
    let id = photosFetcher.localIdentifierForAsset(at: indexPath)
    cell.representedAssetIdentifier = id
    
    photosFetcher.requestCachedImage(
      at: indexPath,
      targetSize: cell.photoImageView.bounds.size
    ) { [weak self] cachedImage in
      if let image = cachedImage, cell.representedAssetIdentifier == id {
        DispatchQueue.global(qos: .userInitiated).async {
          self?.photoFilterApplier(image) { filterResult in
            DispatchQueue.main.async {
              if case let .success(filteredImage) = filterResult,
                 cell.representedAssetIdentifier == id {
                cell.photoImageView.image = filteredImage
              }
            }
          }
        }
      }
    }
    return cell
  }
}
