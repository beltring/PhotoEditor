//
//  CGSizeExtension.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 25.11.22.
//

import UIKit

extension CGSize {

    var point: CGPoint {
        return CGPoint(x: width, y: height)
    }

    func multiply(_ val: CGFloat) -> CGSize {
        return CGSize(width: width * val, height: height * val)
    }

    static func square(side: CGFloat) -> Self {
        return .init(width: side, height: side)
    }
}
