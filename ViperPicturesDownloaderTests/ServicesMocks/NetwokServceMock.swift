//
//  NetwokServceMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 12.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
@testable import ViperPicturesDownloader

class NetworkServiceMock: NetworkServiceProtocol {
	var result: Data = UIImage(named: "defaultImage")!.pngData()!

	func getData(url: URL, completion: @escaping (Data) -> ()) {
		completion(result)
	}


}
