//
//  ToolCell.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 23.11.22.
//

import UIKit

class ToolCell: UICollectionViewCell {

    @IBOutlet private weak var toolImageView: UIImageView!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!

    override func prepareForReuse() {
        super.prepareForReuse()
        toolImageView.image = nil
    }

    func configure(image: UIImage?) {
        toolImageView.image = image
    }

    func configure(constraintConstant: CGFloat = 0) {

        self.topConstraint.constant = constraintConstant
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) {
            self.layoutIfNeeded()
        }
    }
}
