//
//  PencilKitInterface.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 21.12.22.
//

import UIKit

protocol PencilKitDelegate: AnyObject {
    func snapshot(from canvas: PKCanvas) -> UIImage
}

extension PencilKitDelegate {
    func snapshot(from canvas: PKCanvas) -> UIImage {
        return UIImage()
    }
}

protocol PencilKitInterface: NSObject {
    var pencilKitCanvas: PKCanvas { get set }
    func createPencilKitCanvas(frame: CGRect, delegate: PencilKitDelegate) -> PKCanvas
    func updateCanvasOrientation(with frame: CGRect)
}

extension PencilKitInterface {
    func createPencilKitCanvas(frame: CGRect, delegate: PencilKitDelegate) -> PKCanvas {
        pencilKitCanvas = PKCanvas(frame: frame)
        pencilKitCanvas.pencilKitDelegate = delegate
        return pencilKitCanvas
    }

    func updateCanvasOrientation(with frame: CGRect) {
        pencilKitCanvas.updateCanvasOrientation(with: frame)
    }
}
