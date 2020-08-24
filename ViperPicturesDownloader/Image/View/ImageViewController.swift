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

	override func viewDidLoad() {
		super.viewDidLoad()
		//configurator.configure(with: self)
		outputView.configureView()
	}

}
// MARK: - ImageViewInput
extension ImageViewController: ImageViewInput {

	func backgroundColor() {
		view.backgroundColor = .white
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
//		imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
		imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
	}
}
