//
//  PhotoImageTableViewCell.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 20.05.2021.
//

import UIKit

class PhotoImageTableViewCell: UITableViewCell {
  @IBOutlet weak var photoImageView: UIImageView!
  var representedAssetIdentifier: String!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageView.image = nil
  }
  
}
