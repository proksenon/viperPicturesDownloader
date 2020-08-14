//
//  TableViewMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
@testable import ViperPicturesDownloader

class TableViewMock: UITableView {
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
