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
	var viewOutput: Presenter!
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
		viewOutput.configureView()
	}

}
// MARK: - MainViewInput
extension MainViewController: MainViewInput {
	func setTableView() {
		tableView = CustomTableView()
		view.addSubview(tableView)
		tableView.setTableView(viewController: self)
		customTableViewDataSource = CustomTableViewDataSource(tableView: tableView, presenter: viewOutput)
		customTableViewDelegate = CustomTableViewDelegate(tableView: tableView, presenter: viewOutput)
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
		viewOutput.pushCollection()
	}
}
