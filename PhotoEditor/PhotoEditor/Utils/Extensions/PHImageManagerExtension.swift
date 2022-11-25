//
//  PHImageManager.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 25.11.22.
//

import UIKit
import Photos

extension PHImageManager {
    @discardableResult
    func fetchPreview(
        asset: PHAsset,
        size: CGSize,
        completion: @escaping (UIImage?, Bool) -> Void
    ) -> ()->() {
        let size = size.multiply(UIScreen.main.scale)

        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true

        let id = requestImage(for: asset,
                              targetSize: size,
                              contentMode: .aspectFill,
                              options: options,
                              resultHandler:
                                { image, info in
            let isDegraded = info?[PHImageResultIsDegradedKey] as? NSNumber
            let isFullyLoadded = isDegraded?.boolValue == false
            completion(image, isFullyLoadded)
        })
        return { [manager = self] in manager.cancelImageRequest(id) }
    }

    @discardableResult
    func fetchFullImage(
        asset: PHAsset,
        completion: @escaping (UIImage?) -> Void)
    -> ()->() {
        let size = CGSize(width: CGFloat(asset.pixelWidth), height: CGFloat(asset.pixelHeight))

        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.resizeMode = .exact
        options.deliveryMode = .highQualityFormat

        let id = requestImage(for: asset,
                              targetSize: size,
                              contentMode: .aspectFill,
                              options: options,
                              resultHandler:
                                { image, info in
            completion(image)
        })
        return { [manager = self] in manager.cancelImageRequest(id) }
    }
}

