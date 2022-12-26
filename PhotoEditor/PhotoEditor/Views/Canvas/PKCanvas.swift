//
//  PKCanvas.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 20.12.22.
//

import UIKit
import PencilKit

class PKCanvas: UIView {

    var canvasView: PKCanvasView!
    var image: UIImage?
    weak var pencilKitDelegate: PencilKitDelegate?

    //MARK: - iOS Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPencilKitCanvas()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPencilKitCanvas() {
        canvasView = PKCanvasView(frame:self.bounds)
        canvasView.delegate = self
        canvasView.alwaysBounceVertical = false
        canvasView.allowsFingerDrawing = true
        canvasView.becomeFirstResponder()
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 30)
        addSubview(canvasView)
    }

    func updateImage() {
        guard let image = image else { return }
        canvasView.backgroundColor = UIColor(patternImage: image)
        canvasView.contentMode = .scaleToFill
    }

    func updateCanvasUI(frame: CGRect) {
       //2. Update PencilKit Orientation
    }

    func updateCanvasOrientation(with frame: CGRect) {
        self.canvasView.frame = frame
        self.frame = frame
    }

}

// MARK: Canvas View Delegate
extension PKCanvas: PKCanvasViewDelegate {

    /// Delegate method: Note that the drawing has changed.
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print("canvasViewDrawingDidChange")
    }
}

extension PKCanvas: PKToolPickerObserver {

    func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
        print("toolPickerSelectedToolDidChange")
    }

    func toolPickerIsRulerActiveDidChange(_ toolPicker: PKToolPicker) {
        print("toolPickerIsRulerActiveDidChange")
    }

    func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
        print("toolPickerVisibilityDidChange")
    }

    func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
        print("toolPickerFramesObscuredDidChange")
    }
}
