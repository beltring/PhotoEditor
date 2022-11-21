//
//  GalleryViewController.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 18.11.22.
//

import UIKit
import Photos

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var allPhotos: PHFetchResult<PHAsset>?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                DispatchQueue.main.sync {
                    self.collectionView.reloadData()
                }
            case .denied, .restricted:
                print("\n MYLOG: Not allowed")
            case .notDetermined:
                print("\n MYLOG: Not determined yet")
            default:
                break
            }
        }

    }

}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let asset = allPhotos?.object(at: indexPath.row)
        let cell = GalleryCell.dequeueReusableCell(in: collectionView, for: indexPath)
        cell.configure(asset: asset)

        return cell
    }

}
