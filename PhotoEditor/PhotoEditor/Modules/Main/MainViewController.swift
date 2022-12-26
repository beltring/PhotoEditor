//
//  MainViewController.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 18.11.22.
//

import UIKit
import PencilKit
import Photos

class MainViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!

    private lazy var sliderView: SliderView = {
        let slider = SliderView(frame: .zero)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isHidden = true
        return slider
    }()

    private lazy var toolsView: ToolsView = {
        let toolsView = ToolsView(frame: .zero, delegate: self)
        toolsView.translatesAutoresizingMaskIntoConstraints = false
        return toolsView
    }()

    private lazy var backButton2: UIButton = {
        let button = UIButton(frame: .zero)
        
        return button
    }()

    private lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Draw", "Text"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentTintColor = .init(red: 93/255, green: 93/255, blue: 93/255, alpha: 1)
        control.backgroundColor = .init(red: 25/255, green: 25/255, blue: 24/255, alpha: 1)
        control.selectedSegmentIndex = 0
//        mySegmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        return control
    }()

    var asset: PHAsset?

    var pencilKitCanvas =  PKCanvas()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        [
            sliderView,
            toolsView,
            segmentControl
        ].forEach { view.addSubview($0) }

        setupUI()

        guard let asset = asset else { return }
        imageView.fetchImage(asset: asset, contentMode: .aspectFill, targetSize: imageView.frame.size)
    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        addPencilKit()
//        guard
//            let window = view.window,
//            let toolPicker = PKToolPicker.shared(for: window) else { return }
//
//        toolPicker.setVisible(true, forFirstResponder: pencilKitCanvas)
//        toolPicker.addObserver(pencilKitCanvas)
//        pencilKitCanvas.becomeFirstResponder()
//    }

    // MARK: - iOS override properties
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - SetupUI

    private func setupUI() {
        NSLayoutConstraint.activate([
            sliderView.bottomAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            sliderView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
            sliderView.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor),
            sliderView.heightAnchor.constraint(equalToConstant: 30),

            toolsView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor),
            toolsView.trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor),
            toolsView.bottomAnchor.constraint(equalTo: segmentControl.topAnchor, constant: -5),
            toolsView.heightAnchor.constraint(equalToConstant: 85),

            segmentControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            segmentControl.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor)
        ])
    }

    private func addPencilKit() {
        view.backgroundColor = .clear

        pencilKitCanvas = createPencilKitCanvas(frame: view.frame, delegate: self)
        pencilKitCanvas.image = imageView.image
        view.addSubview(pencilKitCanvas)
        pencilKitCanvas.updateImage()
    }

    // MARK: - Actions

    @IBAction func tappedButton(_ sender: UIButton) {
        segmentControl.isHidden = false
        sliderView.isHidden = true
    }

    @IBAction func tappedBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

// MARK: - ToolsViewDelegate

extension MainViewController: ToolsViewDelegate {
    func didTapTool(isShowToolThickness: Bool) {
        segmentControl.isHidden = !isShowToolThickness
        sliderView.isHidden = isShowToolThickness
    }
}

extension MainViewController: PencilKitInterface { }

extension MainViewController: PencilKitDelegate { }
