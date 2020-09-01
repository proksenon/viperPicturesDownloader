//
//  FilterModel.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 31.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

///		Модель данных фильтра картинки
struct Filter {
	var filter: (UIImage?, CustomParameters?)->UIImage?
	var imageModel: Image?
	var parametrs: [DefaultParameters]?

}
