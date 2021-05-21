//
//  ViewController.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 20.05.2021.
//

import UIKit

class ViewController: UITableViewController {
  private lazy var photosFetcher: PhotosFetcherProtocol = PhotosFetcher()
  private lazy var photoFilterApplier: PhotoFilterApplier = UIImage.applyingSepiaFilter
  
  override func viewDidLoad() {
    super.viewDidLoad()
    photosFetcher.fetchAssets()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photosFetcher.numberOfAssets()
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! PhotoImageTableViewCell
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
              if case let ApplyingFilterResult.success(filteredImage) = filterResult,
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
