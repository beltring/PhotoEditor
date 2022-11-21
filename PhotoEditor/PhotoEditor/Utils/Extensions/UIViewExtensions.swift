//
//  UIViewExtensions.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 18.11.22.
//

import UIKit

typealias LoadOptions = [AnyHashable: Any]

extension UIView {
    func startShimmeringAnimation() {

        layer.compositingFilter = "CIHardLightBlendMode"

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 8
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        let gradientColorOne = UIColor.white.withAlphaComponent(0.1).cgColor
        let gradientColorTwo = UIColor.white.withAlphaComponent(0.5).cgColor
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.25
        gradientLayer.add(animation, forKey: animation.keyPath)
        layer.addSublayer(gradientLayer)
    }
}

extension UIView {

    class var name: String {
        return String(describing: self)
    }

    class func instance(from nibType: UIView.Type, owner: Any? = nil, options: LoadOptions? = nil, bundle: Bundle = Bundle.main) -> Self {

        return instance(from: nibType.name, owner: owner, options: options, bundle: bundle)
    }

    class func instance(from nibName: String? = nil, owner: Any? = nil, options: LoadOptions? = nil, bundle: Bundle = Bundle.main) -> Self {

        return view(from: nibName ?? name, owner: owner, options: options, bundle: bundle)
    }

    // MARK: - Private

    // swiftlint:disable force_cast
    private class func view<T: UIView>(from nibName: String, owner: Any?, options: LoadOptions?, bundle: Bundle = Bundle.main) -> T {
        return bundle.loadNibNamed(nibName, owner: owner, options: options as? [UINib.OptionsKey: Any])?.first(where: { $0 is T }) as! T
    }
}
