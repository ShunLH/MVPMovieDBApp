//
//  HomePresenter.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 10/13/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
import RealmSwift

protocol HomePresenter : BasePresenter {
	func attachView(view:HomeView)
	func onHandleRefreshControl()
	func getMovieListByCategory(category : Category) -> Results<MovieVO>?
	func onClickMovieDetail(movieId:Int)
	
}
