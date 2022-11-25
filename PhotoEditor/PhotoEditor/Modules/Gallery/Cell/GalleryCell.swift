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
    @IBOutlet weak var durationLabel: UILabel!

    var assetId: String?
    var onReuse: (() -> ())?

    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse?()
        durationLabel.isHidden = true
        self.assetId = nil
    }

    func configure(content: Content) {
        switch content {
        case .image(let preview):
            galleryImageView.image = preview
            durationLabel.isHidden = true
        case .video(let preview, let duration):
            galleryImageView.image = preview
            durationLabel.isHidden = false
            durationLabel.text = durationString(duration)
        }
    }

    private func durationString(_ duration: Double) -> String {
        let seconds = Int(duration.truncatingRemainder(dividingBy: 60))
        let mins = Int(duration / 60)
        let hours = Int(duration / 3600)

        let withZeros = { (val: Int) -> String in
            return String(format: "%02d", val)
        }

        if hours == 0 {
            return "\(mins):" + withZeros(seconds)
        } else {
            return "\(hours)" + withZeros(mins) + ":" + withZeros(seconds)
        }
    }
}
