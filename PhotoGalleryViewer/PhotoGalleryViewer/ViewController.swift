//
//  ViewController.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 20.05.2021.
//

import UIKit

class ViewController: UITableViewController {
  
  private var photos = [UIImage]()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! PhotoImageTableViewCell
    let photo = photos[indexPath.row]
    cell.photoImageView.image = photo
    return cell
  }

}

