//
//  ImageViewController.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
/// Экран с картинкой
class ImageViewController: UIViewController {

	typealias Presenter = ImageViewOutput & FilterCollectionViewDataSourceOutput & FilterCollectionViewDelegateOutput
	var outputView: Presenter!
	var moduleInput: ImageModuleInput!
	let configurator: ImageConfiguratorProtocol = ImageConfigurator()
	var collectionView: FilterCollectionView!
	var filterCollectionDataSource: FilterCollectionViewDataSource!
	var filterCollectionDelegate: FilterCollectionViewDelegate!
	var imageView: UIImageView!
	var saveImageButton: UIBarButtonItem!
	var alertVC: UIAlertController!
	var slider1: UISlider!
	var slider2: UISlider!
	var slider3: UISlider!
	var sliders: [UISlider]!
	var cancleButton: UIButton!
	var lastValue: Float = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		//configurator.configure(with: self)
		outputView.configureView()
	}

}
// MARK: - ImageViewInput
extension ImageViewController: ImageViewInput {

	func backgroundColor() {
		view.backgroundColor = UIColor.gray
	}

	func setCancleButton() {
		cancleButton = UIButton()
		cancleButton.setTitle("Cancle", for: .normal)
		cancleButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		cancleButton.addTarget(self, action: #selector(cancleButtonDidTapped), for: .touchUpInside)
		view.addSubview(cancleButton)
	}
	func setCancleButtonConstraints() {
		cancleButton.translatesAutoresizingMaskIntoConstraints = false
		cancleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		cancleButton.bottomAnchor.constraint(equalTo: slider1.topAnchor, constant: -20).isActive = true
		cancleButton.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive = true
		cancleButton.widthAnchor.constraint(equalToConstant: CGFloat(100)).isActive = true
	}

	@IBAction func cancleButtonDidTapped() {
		outputView.hidenSlidersAndShowCollection()
	}

	func isHiddenCancleButton(_ isHidden: Bool) {
		cancleButton.isHidden = isHidden
	}

	func setupSliders() {
		slider1 = UISlider()
		slider2 = UISlider()
		slider3 = UISlider()
		sliders = [slider1, slider2, slider3]
		for var slider in sliders {
			setupSlider(slider: &slider)
		}
	}

	private func setupSlider(slider: inout UISlider) {
		slider.addTarget(self, action: #selector(sliderAction), for: .touchUpInside)
		slider.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		slider.maximumTrackTintColor = .white
		view.addSubview(slider)
	}

	func setSlidersConstraint() {
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

	func setDefaultValueToSlider(sliderNubme: Int, minValue: Float, maxValue: Float, defaultValue: Float) {
		sliders[sliderNubme].maximumValue = maxValue
		sliders[sliderNubme].minimumValue = minValue
		sliders[sliderNubme].setValue(defaultValue, animated: true)
	}

	@IBAction func sliderAction(sender: UISlider) {
		if lastValue + 0.01 < sender.value || lastValue - 0.01 > sender.value {
			outputView.filterImage(customParametr: CustomParametrs(parametrs: [slider1.value, slider2.value, slider3.value]))
			lastValue = round(sender.value*100)/100
		}
	}

	func ishiddenCollection(_ isHidden: Bool) {
		collectionView.isHidden = isHidden
	}
	
	func isHiddenSliders(count: Int, _ isHidden: Bool) {
		for index in 0..<count {
			sliders[index].isHidden = isHidden
		}
	}

	func setUpImageView() {
		imageView = UIImageView()
		view.addSubview(imageView)
	}

	func configureImageView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		imageView.contentMode = .scaleAspectFit
	}
	func setUpCollection() {
		collectionView = FilterCollectionView()
		view.addSubview(collectionView)
		filterCollectionDataSource = FilterCollectionViewDataSource(collectionView: collectionView, output: outputView)
		filterCollectionDelegate = FilterCollectionViewDelegate(collectionView: collectionView, output: outputView)
	}

	func constraintCollection() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		collectionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
	}

	func setImage(with image: Image) {
		imageView.image = image.image
	}

	func setUpSaveButton() {
		saveImageButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveImage(_ :)))
		navigationItem.rightBarButtonItem = saveImageButton
	}

	@objc func saveImage(_ sender: UIBarButtonItem) {
		UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil,nil)
		alertVC = UIAlertController(title: "Успешно", message: "Картинка добавлена", preferredStyle: .alert)
		self.present(alertVC, animated: true) { [weak alertVC] in
			sleep(1)
			alertVC?.dismiss(animated: true, completion: nil)
		}
	}

}
