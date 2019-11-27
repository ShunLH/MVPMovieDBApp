//
//  ProfilePresenter.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/27/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation

protocol ProfilePresenter : BasePresenter {
	func attachView(view:ProfileView)
	func getAccountDetails(session_id : String)
	func onClickLogout()
	func onClickMovieDetail(movieId:Int)
	

}
