//
//  UIAlertController+Extensions.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 22.05.2021.
//

import UIKit

extension UIAlertController {
  static func settings() -> UIAlertController {
    let alertController = UIAlertController(title: "Access denied", message: "Go to Settings and grant access to your photos library to be able to display them.", preferredStyle: .alert)
    
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
      let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
      if UIApplication.shared.canOpenURL(settingsUrl) {
        UIApplication.shared.open(settingsUrl)
      }
    }
    alertController.addAction(settingsAction)
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alertController.addAction(cancelAction)
    
    return alertController
  }
}
