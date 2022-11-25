//
//  CGSizeExtension.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 25.11.22.
//

import UIKit

extension CGSize {

    func multiply(_ val: CGFloat) -> CGSize {
        return CGSize(width: width * val, height: height * val)
    }
}
