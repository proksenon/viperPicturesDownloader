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

	typealias Presenter = MainViewOutput & TableViewDataSourceOutPut & TableViewDelegateOutput
	var output: Presenter!
	var configurator: MainConfiguratorProtocol!
	var tableView: CustomTableView!
	var customTableViewDataSource: CustomTableViewDataSource!
	var customTableViewDelegate: CustomTableViewDelegate!
	/// кнопка перехода на колекшн вью
	var segueToCollection: UIBarButtonItem!

	init(configurator: MainConfiguratorProtocol = MainConfigurator()) {
		super.init(nibName: nil, bundle: nil)
		self.configurator = configurator
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(with: self)
		output.configureView()
	}

}
// MARK: - MainViewInput
extension MainViewController: MainViewInput {
	func setTableView() {
		tableView = CustomTableView()
		view.addSubview(tableView)
//		tableView.setTableView(viewController: self)
		customTableViewDataSource = CustomTableViewDataSource(tableView: tableView, output: output)
		customTableViewDelegate = CustomTableViewDelegate(tableView: tableView, output: output)
	}
	func setTableConstraints() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -50),
			tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 50),
			tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
			tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
		])
	}
	func setButton() {
		segueToCollection = UIBarButtonItem(title: "Collection",
								 style: UIBarButtonItem.Style.done,
								 target: self,
								 action: #selector(makeCollection(_:))
								)
		navigationItem.rightBarButtonItem = segueToCollection
	}

	@objc func makeCollection(_ sender: UIBarButtonItem? = nil){
		output.pushCollection()
	}

	func setUpNavigationBar() {
		navigationController?.hidesBarsOnSwipe = true
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = true
		navigationController?.view.backgroundColor = UIColor.clear
	}
}
