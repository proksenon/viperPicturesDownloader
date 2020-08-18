//
//  CustomTableView.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 03.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//
import UIKit

final class CustomTableView: UITableView {

	init() {
		super.init(frame: .zero, style: .grouped)
		register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
		tableFooterView = UIView()
		separatorStyle = .none

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
