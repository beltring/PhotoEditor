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

    private lazy var colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var topConstraint: NSLayoutConstraint!
    private var heightColorConstraint: NSLayoutConstraint!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func configure(image: UIImage?, color: UIColor = .white) {
        addSubview(imageView)
        addSubview(colorView)
        imageView.image = image
        configureConstraints()
    }

    func configure(constraintConstant: CGFloat = 0) {

        self.topConstraint.constant = constraintConstant
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) {
            self.layoutIfNeeded()
        }
    }

    func configure(color: UIColor, constraintConstant: CGFloat = 0) {
        heightColorConstraint.constant = constraintConstant
        heightColorConstraint.isActive = true
        colorView.backgroundColor = color
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) {
            self.layoutIfNeeded()
        }
    }

    private func configureConstraints() {
        topConstraint = imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        heightColorConstraint = colorView.heightAnchor.constraint(equalToConstant: 15)
        heightColorConstraint.isActive = true
        topConstraint.isActive = true
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            colorView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 2),
            colorView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -2),
            colorView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20)
        ])
    }
}
