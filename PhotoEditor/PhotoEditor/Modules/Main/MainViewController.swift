//
//  MainViewController.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 18.11.22.
//

import UIKit
import PencilKit
import Photos
import FlexColorPicker

class MainViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var colorPickerButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!

    private lazy var sliderView: SliderView = {
        let slider = SliderView(frame: .zero)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isHidden = true
        slider.delegate = self
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
    var selectedColor: UIColor?

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

    // MARK: - Actions

    @IBAction func tappedButton(_ sender: UIButton) {
        segmentControl.isHidden = false
        sliderView.isHidden = true
    }

    @IBAction func tappedColorPickerButton(_ sender: UIButton) {
        let colorPickerController = DefaultColorPickerViewController()
        colorPickerController.delegate = self
        present(colorPickerController, animated: true)
    }

    @IBAction func tappedBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @IBAction func tappedAddButton(_ sender: UIButton) {
        print("\n MYLOG: tappedAddButton")

    }

    @IBAction func tappedSaveButton(_ sender: UIButton) {
        print("\n MYLOG: Save image")
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    }
}

// MARK: - ToolsViewDelegate

extension MainViewController: ToolsViewDelegate {
    func didTapTool(isShowToolThickness: Bool) {
        segmentControl.isHidden = !isShowToolThickness
        sliderView.isHidden = isShowToolThickness
    }
}

// MARK: - SliderViewDelegate

extension MainViewController: SliderViewDelegate {
    func didSelectWidth(width: Float) {
        print("\n MYLOG: width \(width)")
        let color = selectedColor ?? .white
        toolsView.configureWitdh(width: width, color: color)
    }
}

// MARK: - ColorPickerDelegate

extension MainViewController: ColorPickerDelegate {

    func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
        // code to handle that user selected a color without confirmed it yet (may change selected color)
        self.selectedColor = selectedColor
        colorView.backgroundColor = selectedColor
        toolsView.configureWitdh(width: 1, color: selectedColor)
    }

    func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
        // code to handle that user has confirmed selected color
        self.selectedColor = confirmedColor
        colorView.backgroundColor = confirmedColor
        toolsView.configureWitdh(width: 1, color: confirmedColor)
    }
}
