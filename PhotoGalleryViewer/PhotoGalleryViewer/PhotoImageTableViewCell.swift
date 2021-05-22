//
//  PhotoImageTableViewCell.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 20.05.2021.
//

import UIKit

class PhotoImageTableViewCell: UITableViewCell {
  static let identifier = "PhotoImageTableViewCellIdentifier"
  
  @IBOutlet weak var photoImageView: UIImageView!
  
  var representedAssetIdentifier: String!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageView.image = nil
  }
  
}
