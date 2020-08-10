//
//  TableViewOutputProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol TableViewDataSourceOutPutProtocol: class {
	func setUpActivity(viewModel: ViewForActivity)
	func startActivity()
	func stopActivity()
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	func numberOfRows() ->Int
}
