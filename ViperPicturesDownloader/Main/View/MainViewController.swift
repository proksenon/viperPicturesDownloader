//
//  ViewController.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
// View главного экрана 
final class MainViewController: UIViewController {

	var output: MainViewOutput?
	var configurator: MainConfiguratorProtocol?
	var tableView: UITableView?
	private var alertVC: UIAlertController?
	private var alertHelper: AlertHelperProtocol?
	private var addUrlButton: UIBarButtonItem?
	/// кнопка segueToCollection переход на колекшн вью
	private var segueToCollection: UIBarButtonItem?

	init(configurator: MainConfiguratorProtocol = MainConfigurator()) {
		super.init(nibName: nil, bundle: nil)
		self.configurator = configurator
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		guard let configurator = configurator else { return }
		configurator.configure(with: self)
		guard let output = output else { return }
		output.configureView()
	}

}
// MARK: - MainViewInput
extension MainViewController: MainViewInput {

	func setViewBackgroud() {
		view.backgroundColor = .gray
	}

	func setTableView() {
		if let tableView = tableView {
			view.addSubview(tableView)
		}
	}

	func setTableConstraints() {
		guard let tableView = tableView else {return}
		tableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 0),
			tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
			tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
			tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
		])
	}
	
	func reloadTable() {
		guard let tableView = tableView else {return}
		tableView.reloadData()
	}

	func scrollTableTo(indexPath: IndexPath) {
		guard let tableView = tableView else {return}
		tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
	}

	func setSegueToCollectionButton() {
		segueToCollection = UIBarButtonItem(title: "Collection",
								 style: UIBarButtonItem.Style.done,
								 target: self,
								 action: #selector(makeCollection(_:))
								)
		navigationItem.leftBarButtonItem = segueToCollection
	}

	@objc func makeCollection(_ sender: UIBarButtonItem? = nil){
		guard let output = output else { return }
		output.pushCollection()
	}

	func setAddUrlButton() {
		addUrlButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
								 style: UIBarButtonItem.Style.done,
								 target: self,
								 action: #selector(addUrl(_:))
								)
		navigationItem.rightBarButtonItem = addUrlButton
	}

	@objc func addUrl(_ sender: UIBarButtonItem? = nil){
		guard let output = output else { return }
		output.presentAlert()
	}

	func setUpNavigationBar() {
		navigationController?.hidesBarsOnSwipe = true
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = true
		navigationController?.view.backgroundColor = UIColor.clear
	}

	func setStatusBarStyleLight() {
		UIApplication.shared.statusBarStyle = .lightContent
	}

	func setupAlert() {
		alertVC = UIAlertController(title: "Введите ссылку на картинку", message: nil, preferredStyle: .alert)
		alertHelper = AlertHelper()
		guard let alertHelper = alertHelper else { return }
		guard let alertVC = alertVC else { return }
		guard let output = output else { return }
		alertHelper.setupAlert(alertVC: alertVC)
		alertHelper.alertTextFieldSet()
		alertHelper.alertAddButtonSet { (urlString) in
			if alertVC.textFields?.first?.text != "" {
				output.didAddUrl(urlString: urlString)
			}
		}
		alertHelper.alertCancleButtonSet()
		let alertPhoto = UIAlertAction(title: "photo", style: .default) { [weak self] (action) in
			self?.showImagePickerController(source: .photoLibrary)
		}
		let alertCamera = UIAlertAction(title: "camera", style: .default) { [weak self] (action) in
			self?.showImagePickerController(source: .camera)
		}
		alertVC.addAction(alertPhoto)
		alertVC.addAction(alertCamera)
	}

	func presentAlert() {
		guard let alertVC = alertVC else {return}
		self.present(alertVC, animated: true)
	}
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	func showImagePickerController(source: UIImagePickerController.SourceType) {
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.allowsEditing = false
		imagePickerController.sourceType = source
		present(imagePickerController, animated: true, completion: nil)
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let output = output else { return }
		let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
		let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
		output.imageFromLibrary(image: Image(image: image, urlString: imageUrl?.absoluteString))
		dismiss(animated: true, completion: nil)
	}
}
