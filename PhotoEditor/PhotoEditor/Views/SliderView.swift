//
//  SliderView.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 23.11.22.
//

import UIKit

protocol SliderViewDelegate: AnyObject {
    func didSelectWidth(width: Float)
}

final class SliderView: UIView {

    weak var delegate: SliderViewDelegate?

    // MARK: - UIElements

    private lazy var slider: UISlider = {
        let slider = UISlider(frame: .zero)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValueImage = nil
        slider.maximumValueImage = nil
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.minimumValue = 0.5
        slider.maximumValue = 15.0
        slider.tintColor = .clear
        return slider
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sliderBackground"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        [
            imageView,
            slider
        ].forEach { addSubview($0) }

        configureConstraint()
        slider.addTarget(self, action: #selector(updateWidth(sender:)), for: .allEvents)
    }

    // To use
    @objc private func updateWidth(sender: UISlider!) {
        let step: Float = 0.5
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        delegate?.didSelectWidth(width: sender.value)
    }

    private func configureConstraint() {
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor),
            slider.topAnchor.constraint(equalTo: topAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor),

            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
