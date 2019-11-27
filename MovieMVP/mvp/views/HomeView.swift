//
//  HomeView.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 10/13/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation

protocol HomeView : BaseView {
	
	func displayData()
	func reloadTableView(atIndexPath:IndexPath)
	func showMovieDetail(movieId:Int)

	
}
