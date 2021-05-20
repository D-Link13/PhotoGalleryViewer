//
//  ViewController.swift
//  PhotoGalleryViewer
//
//  Created by Dmitry Tsurkan on 20.05.2021.
//

import UIKit
import Photos

class ViewController: UITableViewController {
  private var fetchResult: PHFetchResult<PHAsset>!
  private let imageManager = PHCachingImageManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if fetchResult == nil {
      let allPhotosOptions = PHFetchOptions()
      allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
      fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchResult.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! PhotoImageTableViewCell
    let asset = fetchResult.object(at: indexPath.item)
    cell.representedAssetIdentifier = asset.localIdentifier
    imageManager.requestImage(for: asset,
                              targetSize: cell.photoImageView.bounds.size,
                              contentMode: .aspectFit,
                              options: nil) { [weak self] image, _ in
      if let image = image, cell.representedAssetIdentifier == asset.localIdentifier {
        cell.photoImageView.image = self?.applySepiaFilter(image)
      }
    }
    return cell
  }
  
  private func applySepiaFilter(_ image: UIImage) -> UIImage? {
    guard let data = image.pngData() else { return nil }
    let inputImage = CIImage(data: data)
        
    let context = CIContext(options: nil)
        
    guard let filter = CIFilter(name: "CISepiaTone") else { return nil }
    filter.setValue(inputImage, forKey: kCIInputImageKey)
    filter.setValue(0.8, forKey: "inputIntensity")
        
    guard
      let outputImage = filter.outputImage,
      let outImage = context.createCGImage(outputImage, from: outputImage.extent)
    else {
      return nil
    }

    return UIImage(cgImage: outImage)
  }
}
