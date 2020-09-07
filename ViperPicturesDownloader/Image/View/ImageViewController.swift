//
//  ImageViewController.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
/// Экран с картинкой
final class ImageViewController: UIViewController {

	var output: ImageViewOutput?
	var moduleInput: ImageModuleInput?
	var collectionView: UICollectionView?
	weak var previousController: UIViewController?
	private var imageView: UIImageView?
	private var saveImageButton: UIBarButtonItem?
	private var cancelButton: UIButton?
	private var alertVC: UIAlertController?
	private var slider1: UISlider?
	private var slider2: UISlider?
	private var slider3: UISlider?
	private var sliders: [UISlider]?

	override func viewDidLoad() {
		super.viewDidLoad()
		guard let output = output else { return }
		output.configureView()
	}

	override func viewWillDisappear(_ animated: Bool) {
		guard let output = output else { return }

		if previousController is MainViewController {
			self.imageView?.contentMode = .scaleToFill
		}
		output.hidenSlidersAndShowCollection()
		UIView.animate(withDuration: 1, delay: 0, options: .allowUserInteraction, animations: {
			self.view.backgroundColor = .clear
			self.collectionView?.alpha = 0
			self.imageView?.alpha = 0
		})
	}

}
// MARK: - ImageViewInput
extension ImageViewController: ImageViewInput {

	func backgroundColor() {
		view.backgroundColor = UIColor.gray
	}
	// MARK: - CancleButton
	func setCancelButton() {
		cancelButton = UIButton()
		guard let cancelButton = cancelButton else { return }
		cancelButton.setTitle("Cancel", for: .normal)
		cancelButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		cancelButton.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
		view.addSubview(cancelButton)
	}
	func setCancelButtonConstraints() {
		guard let cancelButton = cancelButton else { return }
		guard let slider1 = slider1 else { return }

		cancelButton.translatesAutoresizingMaskIntoConstraints = false
		cancelButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		cancelButton.bottomAnchor.constraint(equalTo: slider1.topAnchor, constant: -20).isActive = true
		cancelButton.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive = true
		cancelButton.widthAnchor.constraint(equalToConstant: CGFloat(100)).isActive = true
	}

	@IBAction func cancelButtonDidTapped() {
		guard let output = output else { return }

		output.hidenSlidersAndShowCollection()
	}

	func isHiddenCancleButton(_ isHidden: Bool) {
		guard let cancelButton = cancelButton else { return }

		cancelButton.isHidden = isHidden
	}
	// MARK: - Sliders
	func setupSliders() {
		slider1 = UISlider()
		slider2 = UISlider()
		slider3 = UISlider()
		guard let slider1 = slider1, let slider2 = slider2, let slider3 = slider3 else { return }
		sliders = [slider1, slider2, slider3]
		guard let sliders = sliders else { return }
		for var slider in sliders {
			setupSlider(slider: &slider)
		}
	}

	private func setupSlider(slider: inout UISlider) {
		slider.addTarget(self, action: #selector(sliderAction), for: .allTouchEvents)
		slider.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		slider.maximumTrackTintColor = .white
		view.addSubview(slider)
	}

	func setSlidersConstraint() {
		guard let slider1 = slider1, let slider2 = slider2, let slider3 = slider3 else { return }
		setSliderConstaints(slider: slider1, topConstrantTo: view, with: -200)
		setSliderConstaints(slider: slider2, topConstrantTo: slider1, with: 15)
		setSliderConstaints(slider: slider3, topConstrantTo: slider2, with: 15)
	}

	private func setSliderConstaints(slider: UISlider, topConstrantTo: UIView, with constant: CGFloat) {
		slider.translatesAutoresizingMaskIntoConstraints = false
		slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35).isActive = true
		slider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35).isActive = true
		slider.topAnchor.constraint(equalTo: topConstrantTo.bottomAnchor, constant: constant).isActive = true
	}

	func setDefaultValueToSlider(sliderNubmer: Int, minValue: Float, maxValue: Float, defaultValue: Float, identifier: String) {
		guard let sliders = sliders else { return }
		sliders[sliderNubmer].accessibilityIdentifier = identifier
		sliders[sliderNubmer].maximumValue = maxValue
		sliders[sliderNubmer].minimumValue = minValue
		sliders[sliderNubmer].setValue(defaultValue, animated: true)
	}

	@IBAction func sliderAction(sender: UISlider) {
		guard let output = output else { return }
		guard let identifier = sender.accessibilityIdentifier else {return}
		output.didChangeFiltersParameters(key: identifier, value: sender.value)
	}

	func isHiddenSliders(count: Int, _ isHidden: Bool) {
		guard let sliders = sliders else { return }

		for index in 0..<count {
			sliders[index].isHidden = isHidden
		}
	}
	// MARK: - ImageView
	func setUpImageView() {
		imageView = UIImageView()
		guard let imageView = imageView else { return }
		view.addSubview(imageView)
	}

	func configureImageView() {
		guard let imageView = imageView else { return }

		imageView.backgroundColor = .clear
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		imageView.contentMode = .scaleAspectFit
	}

	func setImage(with image: ImageModel) {
		guard let imageView = imageView else { return }

		imageView.image = image.image
	}

	// MARK: - CollectionView
	func setUpCollection() {
		guard let collectionView = collectionView else { return }

		view.addSubview(collectionView)
	}

	func constraintCollection() {
		guard let collectionView = collectionView else { return }

		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		collectionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
	}

	func ishiddenCollection(_ isHidden: Bool) {
		guard let collectionView = collectionView else { return }

		collectionView.isHidden = isHidden
	}
	// MARK: - SaveButton
	func setUpSaveButton() {
		saveImageButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveImage(_ :)))
		navigationItem.rightBarButtonItem = saveImageButton
	}

	@objc func saveImage(_ sender: UIBarButtonItem) {
		guard let output = output else { return }

		output.saveImageToLibrary()
		alertVC = UIAlertController(title: "Успешно", message: "Картинка добавлена", preferredStyle: .alert)
		guard let alertVC = alertVC else { return }
		self.present(alertVC, animated: true) { [weak alertVC] in
			sleep(1)
			alertVC?.dismiss(animated: true, completion: nil)
		}
	}
}
