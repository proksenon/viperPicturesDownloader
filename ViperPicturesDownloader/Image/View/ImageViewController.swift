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
	var image: UIImage? {
		didSet {
			origIma = image
		}
	}
	var filtredImage: UIImage?
	var effect: Bool = false
	let filter = ImageFilter()
	var origIma: UIImage?
	var imageView: UIImageView!

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

	func loadImageView() {
//		let view = FullImageView()
//		view.imageView.image = origIma
//		self.view = view
	}

	func setUpImageView() {
		imageView = UIImageView()
		view.addSubview(imageView)
		imageView.image = origIma
	}

	func configureImageView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
	}
	func setUpCollection() {
		collectionView = FilterCollectionView()
		view.addSubview(collectionView)
		//collectionView.setCollectionViewConstraints(collectionViewController: self)
		filterCollectionDataSource = FilterCollectionViewDataSource(collectionView: collectionView, output: outputView)
		filterCollectionDelegate = FilterCollectionViewDelegate(collectionView: collectionView, output: outputView)
	}

	func constraintCollection() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		collectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

	}
	func tapImage() {
//		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapFilter))
//		collectionView.addGestureRecognizer(tapGesture)
	}


	@objc func tapGestureDone(){
		outputView.popViewController()
	}
	/// по тапу применятся на картинку эффект
	@objc func tapFilter() {
		outputView.filterImage()
//		effect = !effect
//		if effect {
//			origIma = filter.edgesFilter(image: image)
//		} else {
//			origIma = image
//		}
//		imageView.image = origIma
	}

	func setImage(with image: Image) {
		imageView.image = image.image
	}
}
