//
//  NetworkServiceTests.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class NetworkServiceTests: XCTestCase {
	var networkService: NetworkServiceProtocol!
	var session: URLSessionMock!
	let url = URL(string: "https://i.pinimg.com/originals/b3/c2/ff/b3c2ff8bcfad7ad8b6af0ceb99ffc7ef.jpg")

    override func setUp() {
		session = URLSessionMock()
		networkService = NetworkService(session: session)
    }

    override func tearDown() {
		session = nil
		networkService = nil
    }

	func testGetData() {
		let data = Data(bytes: [0, 1, 0, 1])
		var result: Data?
        session.data = data
		let expectation = self.expectation(description: #function)

		networkService.getData(url: url!) { (data) in
			result = data
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 10)
		XCTAssertEqual(result, data)
	}

}
