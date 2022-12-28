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

extension UIView {
    var x: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue }
    }

    var y: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue }
    }

    var right: CGFloat {
        get { return frame.maxX }
        set { frame.origin.x = newValue - frame.size.width }
    }

    var bottom: CGFloat {
        get { return frame.maxY }
        set { frame.origin.y = newValue - frame.size.height }
    }

    var width: CGFloat {
        get { return frame.width }
        set { frame.size.width = newValue }
    }

    var height: CGFloat {
        get { return frame.height }
        set { frame.size.height = newValue }
    }

    func frameIn(view: UIView?) -> CGRect {
        return self.convert(bounds, to: view)
    }

    var isInsideAnimationBlock: Bool {
        let act = action(for: layer, forKey: "position")
        if act is NSNull {
            return false
        }
        return act != nil
    }

    func fadeAnimation(duration: Double = 0.2) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        transition.type = CATransitionType.fade

        self.layer.add(transition, forKey: "fade")
    }
}
