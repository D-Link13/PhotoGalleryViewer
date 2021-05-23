//
//  PhotoFilterApplierProtocol.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 23.05.2021.
//

import UIKit

protocol PhotoFilterApplierProtocol {
  func applySepia(to image: UIImage, completion: @escaping ((Result<UIImage, Error>) -> Void))
}
