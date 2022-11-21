//
//  GalleryCell.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 21.11.22.
//

import UIKit
import Photos

class GalleryCell: UICollectionViewCell {

    @IBOutlet private weak var galleryImageView: UIImageView!

    func configure(asset: PHAsset?) {
        guard let asset = asset else { return }
        galleryImageView.fetchImage(asset: asset, contentMode: .aspectFit, targetSize: galleryImageView.frame.size)
    }
}
