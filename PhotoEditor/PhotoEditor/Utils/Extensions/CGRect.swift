//
//  CGRect.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 27.12.22.
//

import UIKit

extension CGRect {
    init(mid: CGPoint, size: CGSize) {
        let origin = mid.subtract(size.point.multiply(0.5))
        self.init(origin: origin, size: size)
    }
}
