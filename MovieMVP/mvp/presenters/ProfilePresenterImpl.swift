//
//  ProfilePresenterImpl.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/27/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
import RealmSwift
class ProfilePresenterImpl: BasePresenter {
	var selectedMovieId : Int = 0
	var watchMoviesList : [MovieVO]!
	var ratedMoviesList : [MovieVO]!
	var realm = try! Realm()
	var userVO = UserVO()
	
	var mView : ProfileView? = nil
	
	func onUIReady() {
		if let sessionId = UserDefaults.standard.string(forKey: DEFAULT_SESSION_ID) {
			self.watchMoviesList = [MovieVO]()
			self.ratedMoviesList = [MovieVO]()
			getAccountDetails(session_id: sessionId)
		}
	}
	
	fileprivate func fetchWatchMoviesList(session_id : String,account_id : Int,completion:@escaping()->Void) {
		
		UserModelImpl.shared.fetchWatchMoviesFromApi(session_id: session_id, accountId: account_id, completion: { [weak self] results in
			if results.isEmpty {
				print("No watch movie list found!")
				return
			}else {
				results.forEach({ [weak self] (movieInfo) in
					self?.watchMoviesList.append(MovieInfoResponse.convertToMovieVO(data: movieInfo, realm: self!.realm))
				})
				print("Watch Movies\(results.count)")
			}
			completion()
			
		})
	}
	
	fileprivate func fetchRatedMoviesList(session_id : String,account_id : Int,completion:@escaping()->Void) {
		UserModelImpl.shared.fetchRatedMoviesFromApi(session_id: session_id, accountId: account_id, completion: { [weak self] results in
			if results.isEmpty {
				print("No rated movies list found!")
				return
			}else {
				results.forEach({ [weak self] (movieInfo) in
					self?.ratedMoviesList.append(MovieInfoResponse.convertToMovieVO(data: movieInfo, realm: self!.realm))
				})
				print("Similar Movies\(results.count)")
			}
			completion()
			
		})
	}
	
}

extension ProfilePresenterImpl : ProfilePresenter {
	func onClickMovieDetail(movieId:Int) {
		self.selectedMovieId = movieId
		self.mView?.showMovieDetail()
	}
	
	
	func getAccountDetails(session_id: String) {
		UserModelImpl.shared.getUserDetailFromApi(success: { (response) in
			self.userVO = LoginResponse.converUserVO(user: response)
			self.fetchWatchMoviesList(session_id: session_id, account_id:self.userVO.accountId) {
				self.fetchRatedMoviesList(session_id: session_id,account_id:self.userVO.accountId) {
					DispatchQueue.main.async {
						LoginResponse.saveUserVO(user: response, ratedMovies: self.ratedMoviesList, watchMovies: self.watchMoviesList, realm: self.realm)
						self.mView?.displayData()
					}
				}
			}
			
		}) { (error) in
			print(error)
		}
	}
	
	func onClickLogout() {
		UserDefaults.standard.removeObject(forKey: DEFAULT_ACCOUNT_ID)
		UserDefaults.standard.removeObject(forKey: DEFAULT_SESSION_ID)
		UserDefaults.standard.removeObject(forKey: DEFAULT_REQUEST_TOKEN)
		mView?.showLoginView()
	}
	
	func attachView(view: ProfileView) {
		self.mView = view
	}
	
	
}
