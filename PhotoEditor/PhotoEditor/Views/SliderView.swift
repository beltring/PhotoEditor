//
//  SliderView.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 23.11.22.
//

import UIKit

final class SliderView: UIView {

    private lazy var slider = UISlider(frame: self.bounds)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
//        slider.
    }
}
