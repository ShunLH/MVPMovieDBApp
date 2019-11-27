//
//  MovieDetailPresenter.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation

protocol MovieDetailPresenter {
	func attachView(view:MovieDetailView)
	func onClickPlayMovie()
	func onClickRateBth()
	func onClickWatchedList()
	
}
