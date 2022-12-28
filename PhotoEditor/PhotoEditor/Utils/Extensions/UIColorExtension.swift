//
//  UIColorExtension.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 27.12.22.
//

import UIKit

extension UIColor {
    var components: ColorComponents {
        var info = ColorComponents(r: 0, g: 0, b: 0, a: 0)
        getRed(&info.r, green: &info.g, blue: &info.b, alpha: &info.a)
        return info
    }
}

struct ColorComponents: Equatable, Codable {
    var r: CGFloat
    var g: CGFloat
    var b: CGFloat
    var a: CGFloat
    func equalRgb(other: ColorComponents) -> Bool {
        return r == other.r && g == other.g && b == other.b
    }
    func toColorOverride(r: CGFloat? = nil, g: CGFloat? = nil, b: CGFloat? = nil, a: CGFloat? = nil) -> UIColor {
        return UIColor(red: r ?? self.r,
                       green: g ?? self.g,
                       blue: b ?? self.b,
                       alpha: a ?? self.a)
    }
    var hex: String {
        return String(format: "%02lX%02lX%02lX",
                      Int(round(r * 255)),
                      Int(round(g * 255)),
                      Int(round(b * 255)))
    }

    var isLightColor: Bool {
        // based on this https://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        let val = CGFloat(r * 299 + g * 587 + b * 114) / 1000.0
        return val > 0.5
    }
}
