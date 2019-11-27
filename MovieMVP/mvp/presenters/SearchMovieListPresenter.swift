//
//  SearchMovieListPresenter.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
protocol SearchMovieListPresenter : BasePresenter {
	func attchView(view:SearchMovieListView)
	func onClickSearch(movieName : String)
	func onClickSearchCancel()
	
	
}
