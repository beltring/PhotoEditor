//
//  PassthroughView.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 27.12.22.
//

import UIKit

class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, with: event)
        return result == self ? nil : result
    }
}
