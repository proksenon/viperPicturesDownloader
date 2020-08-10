//
//  MainPresenterProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol: class {
	func configureView()
	func pushCollection()
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	func numberOfRows() ->Int
	func didSelect(indexPath: IndexPath)
	func setUpActivity(viewModel: ViewForActivity)
	func startActivity()
	func stopActivity()
}
