//
//  UIControlExtension.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 27.12.22.
//

import UIKit

extension UIControl {
    func addAction(
        for controlEvents: UIControl.Event = .touchUpInside,
        _ closure: @escaping VoidBlock
    ) {
        @objc
        final class ClosureContainer: NSObject {
            let closure: VoidBlock
            init(_ closure: @escaping VoidBlock) { self.closure = closure }
            @objc func invoke() { closure() }
        }

        let sleeve = ClosureContainer(closure)
        addTarget(sleeve, action: #selector(ClosureContainer.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
