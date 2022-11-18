//
//  UIViewExtensions.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 18.11.22.
//

import UIKit

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

//    func startShimmeringAnimation() {
//
//        layer.compositingFilter = "CIHardLightBlendMode"
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.cornerRadius = min(bounds.height / 2, 5)
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.5)
//        let gradientColorOne = UIColor.white.withAlphaComponent(0.1).cgColor
//        let gradientColorTwo = UIColor.white.withAlphaComponent(0.5).cgColor
//        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
//        gradientLayer.locations = [0.0, 0.5, 1.0]
//        gradientLayer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
//
//        let animation = CABasicAnimation(keyPath: "locations")
//        animation.fromValue = [-1.0, -0.5, 0.0]
//        animation.toValue = [1.0, 1.5, 2.0]
//        animation.repeatCount = .infinity
//        animation.duration = 1.25
//        gradientLayer.add(animation, forKey: animation.keyPath)
//        layer.addSublayer(gradientLayer)
//    }
}
