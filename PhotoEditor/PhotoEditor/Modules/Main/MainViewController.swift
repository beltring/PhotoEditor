//
//  MainViewController.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 18.11.22.
//

import UIKit
import Photos

class MainViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var backButton: UIButton!

    var asset: PHAsset?

    private var selectedCellIndexPath: IndexPath?

    private var toolImages = [
        UIImage(named: "pen"),
        UIImage(named: "brush"),
        UIImage(named: "neon"),
        UIImage(named: "pencil"),
        UIImage(named: "lasso"),
        UIImage(named: "eraser")
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        guard let asset = asset else { return }
        imageView.fetchImage(asset: asset, contentMode: .aspectFill, targetSize: imageView.frame.size)
    }

    @IBAction func tappedButton(_ sender: UIButton) {
        segmentControl.isHidden = false
        slider.isHidden = true
    }

    @IBAction func tappedBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toolImages.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cell = collectionView.cellForItem(at: indexPath) as? ToolCell
        if selectedCellIndexPath == indexPath {
            cell?.configure()
        } else {
            cell?.configure(constraintConstant: 15)
        }

        return CGSize(width: 25, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ToolCell.dequeueReusableCell(in: collectionView, for: indexPath)
        cell.configure(image: toolImages[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
        }

        if selectedCellIndexPath != nil {
            collectionView.performBatchUpdates(nil)
        }
    }
}
