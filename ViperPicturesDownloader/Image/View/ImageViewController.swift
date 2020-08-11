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

	var outputView: ImageViewOutput!
	let configurator: ImageConfiguratorProtocol = ImageConfigurator()
	var image: UIImage?

	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(with: self)
		outputView.configureView()
	}

}
// MARK: - ImageViewInput
extension ImageViewController: ImageViewInput {

	func backgroundColor() {
		view.backgroundColor = .white
	}

	func loadImageView() {
		let view = FullImageView()
		view.imageView.image = image
		self.view = view
	}

	func tapImage() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGesture)
	}

	@objc func tapGestureDone(){
		outputView.popViewController()
	}
}
