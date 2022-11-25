//
//  OnboardingViewController.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 17.11.22.
//

import UIKit
import PhotosUI

class OnboardingViewController: UIViewController {

    @IBOutlet private weak var duckImageView: UIImageView!
    @IBOutlet private weak var accessButton: UIButton!

    private var selectedImage: UIImage!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        accessButton.layer.cornerRadius = 8
        accessButton.startShimmeringAnimation()

        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "emojiDuck", withExtension: "gif")!)
        let advTimeGif = UIImage.gifImageWithData(imageData!)
        duckImageView.image = advTimeGif
    }

    // MARK: - Actions

    @IBAction func tappedAllowAccessButton(_ sender: UIButton) {
        performSegue(withIdentifier: "Gallery", sender: self)
    }
}

extension OnboardingViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            picker.dismiss(animated: true)
            performSegue(withIdentifier: "Main", sender: self)
        }
    }
}
