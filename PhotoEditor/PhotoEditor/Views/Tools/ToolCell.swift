//
//  ToolCell.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 23.11.22.
//

import UIKit

class ToolCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
//        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var topConstraint: NSLayoutConstraint!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func configure(image: UIImage?) {
        addSubview(imageView)
        imageView.image = image
        configureConstraints()
    }

    func configure(constraintConstant: CGFloat = 0) {

        self.topConstraint.constant = constraintConstant
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) {
            self.layoutIfNeeded()
        }
    }

    private func configureConstraints() {
        topConstraint = imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        topConstraint.isActive = true
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
