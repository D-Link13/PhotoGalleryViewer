//
//  ViewController.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 20.05.2021.
//

import UIKit

class ViewController: UITableViewController {
  private lazy var photoGalleryPresenter: PhotoGalleryPresenter = PhotoGallery()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    photoGalleryPresenter.fetchAssets()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photoGalleryPresenter.numberOfAssets()
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! PhotoImageTableViewCell
    let id = photoGalleryPresenter.localIdentifierForAsset(at: indexPath)
    cell.representedAssetIdentifier = id
    
    photoGalleryPresenter.requestCachedPhotoAsset(at: indexPath, targetSize: cell.photoImageView.bounds.size) { image in
      if let image = image, cell.representedAssetIdentifier == id {
        cell.photoImageView.image = image.applyingSepiaFilter()
      }
    }
    return cell
  }
}
