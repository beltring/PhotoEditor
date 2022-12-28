//
//  UIEdgeInsetsExtension.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 27.12.22.
//

import UIKit

extension UIEdgeInsets {
    static func tm_insets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        return .init(top: top, left: left, bottom: bottom, right: right)
    }

    static func all(_ side: CGFloat) -> Self {
        .init(top: side, left: side, bottom: side, right: side)
    }
}
