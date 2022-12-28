//
//  CGPoint.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 27.12.22.
//

import UIKit

extension CGPoint {
    @inline(__always)
    func subtract(_ p: CGPoint) -> CGPoint {
        return CGPoint(x: x - p.x, y: y - p.y)
    }

    @inline(__always)
    func distance() -> CGFloat {
        return sqrt(x * x + y * y)
    }

    @inline(__always)
    func multiply(_ val: CGFloat) -> CGPoint {
        return CGPoint(x: x * val, y: y * val)
    }
}
