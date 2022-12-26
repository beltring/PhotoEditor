//
//  ToolsView.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 25.11.22.
//

import UIKit

protocol ToolsViewDelegate: AnyObject {
    func didTapTool(isShowToolThickness: Bool)
}

final class ToolsView: UIView {

    private weak var delegate: ToolsViewDelegate?

    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 25, height: 75)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        ToolCell.registerCellClass(in: collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var selectedCellIndexPath: IndexPath?

    private var toolImages = [
        UIImage(named: "pen"),
        UIImage(named: "brush"),
        UIImage(named: "neon"),
        UIImage(named: "pencil"),
        UIImage(named: "lasso"),
        UIImage(named: "eraser")
    ]

    // MARK: - Init

    init(frame: CGRect, delegate: ToolsViewDelegate? = nil) {
        super.init(frame: frame)
        self.delegate = delegate
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetupUI

    private func setup() {
        addSubview(collectionView)
        setupCollectionView()

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate&UICollectionViewDataSource&UICollectionViewDelegateFlowLayout

extension ToolsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

        return CGSize(width: 20, height: 85)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ToolCell.dequeueReusableCell(in: collectionView, for: indexPath)
        cell.configure(image: toolImages[indexPath.row])

        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        let totalCellWidth = 25 * 6
//        let totalSpacingWidth = 40 * (6 - 1)
//
//        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
            delegate?.didTapTool(isShowToolThickness: true)
            return
        } else {
            delegate?.didTapTool(isShowToolThickness: false)
            selectedCellIndexPath = indexPath
        }

        collectionView.performBatchUpdates(nil)
    }
}
