//
//  GalleryViewController.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 18.11.22.
//

import UIKit
import Photos

class GalleryViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    private var selectedAsset: PHAsset?
    private var currentScale: CGFloat = 1
    private var currentIndexPath: IndexPath?
    private lazy var allPhotos = generateResults()
    private var imagesCache: [String: LoadedImageInfo] = [:]
    private let imageManager = PHImageManager.default()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.allPhotos = self.generateResults()
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Main" else { return }
        guard let destination = segue.destination as? MainViewController else { return }
        destination.asset = selectedAsset
    }

    // MARK: - Functions

    private func generateResults() -> PHFetchResult<PHAsset> {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d || mediaType = %d", PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)

        return PHAsset.fetchAssets(with: fetchOptions)
    }
}

// MARK: - ResizableCollectionViewDataSource&ResizableCollectionViewDelegate

extension GalleryViewController: ResizableCollectionViewDataSource, ResizableCollectionViewDelegate {

    func marginBetweenCells(_ collectionView: ResizableCollectionView) -> CGFloat {
        return CGFloat(2)
    }

    func outlineMargin(_ collectionView: ResizableCollectionView) -> CGFloat {
        return CGFloat(2)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let asset = allPhotos.object(at: indexPath.row)
//        selectedAsset = asset
//        performSegue(withIdentifier: "Main", sender: self)
        let asset = allPhotos[indexPath.item]
        guard asset.mediaType == .image else {
            let alert = UIAlertController(title: "Not Supported Yet", message: "Sorry, only images supported for now", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        currentIndexPath = indexPath
        selectedAsset = asset
        performSegue(withIdentifier: "Main", sender: self)

//        let edit = EditVC()
//        let transitionController = ImageDetailTransitionController()
//        transitionController.fromDelegate = self
//        transitionController.toDelegate = edit
//        edit.modalPresentationStyle = .custom
//        edit.transitioningDelegate = transitionController
//        edit.cacheImg = imagesCache[asset.localIdentifier]?.image
//        edit.asset = asset
//        self.transitionController = transitionController
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = GalleryCell.dequeueReusableCell(in: collectionView, for: indexPath)
        let asset = allPhotos[indexPath.item]
        cell.assetId = asset.localIdentifier

        let cached = imagesCache[asset.localIdentifier]

        if let image = cached?.image {
            configureCell(cell, preview: image, asset: asset)
        }
        if cached?.isFullyLoaded != true {
            let side = floor(UIScreen.main.bounds.width / 3) * UIScreen.main.scale
            let imageSize = CGSize(width: side, height: side)
            let loadCancel = imageManager.fetchPreview(asset: asset, size: imageSize) { [weak self] image, isFullyLoaded in
                guard let self = self, cell.assetId == asset.localIdentifier else { return }
                self.imagesCache[asset.localIdentifier] = .init(image: image, isFullyLoaded: isFullyLoaded)
                self.configureCell(cell, preview: image, asset: asset)
            }
            cell.onReuse = loadCancel
        }
        return cell
    }

    private func configureCell(_ cell: GalleryCell, preview: UIImage?, asset: PHAsset) {
        switch asset.mediaType {
        case .image:
            cell.configure(content: .image(preview))
        case .video:
            cell.configure(content: .video(preview, asset.duration))
        case .unknown,  .audio:
            break
        @unknown default:
            break
        }
    }
}
