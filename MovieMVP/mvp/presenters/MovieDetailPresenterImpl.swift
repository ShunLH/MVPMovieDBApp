//
//  MovieDetailPresenterImpl.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
import RealmSwift

class MovieDetailPresenterImpl : BasePresenter {
	var mView : MovieDetailView? = nil
	var similarMoviesResults = [MovieInfoResponse]()
	let realm  = try! Realm()
	var trailerList : [Trailer]?
	var movieId : Int = -1
	var movie = MovieVO()
	var movieDetail : MovieDetailResponse?
	
	init(movieID : Int) {
		self.movieId = movieID
	}
	
	func onUIReady() {
		fetchMovie()
		fetchDetails()
		
	}
	func attachView(view: MovieDetailView) {
		self.mView = view
	}
	
	func fetchMovie(){
		if let movie = MovieVO.getMovieById(movieId: movieId, realm: realm) {
			self.movie = movie
			mView?.displayInitData()
			guard let _ = UserDefaults.standard.string(forKey: DEFAULT_SESSION_ID) else {return}
			let accountId = UserDefaults.standard.integer(forKey: DEFAULT_ACCOUNT_ID)
			if let user = UserVO.getUserById(accountId: accountId, realm: realm) {
				user.watchedMovies.forEach { (watchMovie) in
					if watchMovie.id == movieId
					{
						mView?.handleAddBtn(enable: false)
					}
				}
				user.ratedMovies.forEach { (rateMovie) in
					if rateMovie.id == movieId {
						mView?.setRateBtnImage(image: #imageLiteral(resourceName: "icons8-thumb_up_filled"))
						mView?.handleRateBtn(enable: false)
					}
				}
			}
		}
		
	}
	func fetchDetails(){
		if NetworkUtils.checkReachable() == false {
			mView?.displayAlert(title: "Error", message: "No Internet Connection!")
			return
		}
		fetchMovieTrailer(movieId: movieId)
		fetchMovieDetails(movieId: movieId)
		fetchSimilarMovies(movieId: movieId)
	}
	
	fileprivate func fetchMovieTrailer(movieId : Int) {
		mView?.displayLoading()
		RemoteModelImpl.shared.fetchMovieVideosFromApi(movieId: movieId, success: { (trailers) in
			DispatchQueue.main.async {
				if trailers.isEmpty {
					print("NO movie trailer for movie \(movieId)")
					return
				}else {
					self.trailerList = trailers
				}
				self.mView?.dismissLoading()
				
			}
		}) { (error) in
			print(error)
		}
		
	}
	
	
	fileprivate func fetchMovieDetails(movieId : Int) {
		mView?.displayLoading()
		RemoteModelImpl.shared.fetchMovieDetailsFromApi(movieId: movieId, success: {[weak self] (movieDetails) in
			DispatchQueue.main.async {
				self?.movieDetail = movieDetails
				self?.mView?.dismissLoading()
				self?.mView?.displayMovieDetail()
			}
		}) { (error) in
			print(error)
		}
		
	}
	
	fileprivate func fetchSimilarMovies(movieId : Int) {
		mView?.displayLoading()
		RemoteModelImpl.shared.fetchSimilarMoviesFromApi(movieId: movieId, pageId: 1, success: { (results) in
			self.similarMoviesResults = results
			DispatchQueue.main.async {
				self.mView?.dismissLoading()
				
				if results.isEmpty {
					print("No movie found with name \"\(movieId)\" ")
					return
				}else {
					print("Similar Movies\(results.count)")
					self.mView?.displaySimilarMovies()
					
				}
			}
		}) { (error) in
			print(error)
		}
		
	}
	
	
}
extension MovieDetailPresenterImpl : MovieDetailPresenter {
	func onClickRateBth() {
		if NetworkUtils.checkReachable() == false {
			self.mView?.displayAlert(title: "Error", message: "No Internet Connection!")
			return
		}
		guard let sessionId = UserDefaults.standard.string(forKey: DEFAULT_SESSION_ID) else {
			self.mView?.displayAlert(title: "Please Enter Login", message: "")
			return
			
		}
		let accountId = UserDefaults.standard.integer(forKey: DEFAULT_ACCOUNT_ID)
		UserModelImpl.shared.addToRateMoviesFromApi(movieId: movieId, session_id: sessionId,account_id: accountId) { (response) in
			guard let userVO = UserVO.getUserById(accountId: accountId, realm: self.realm) else {return}
			guard let movie = MovieVO.getMovieById(movieId: self.movieId, realm: self.realm) else {return}
			MovieVO.updateMovieRating(movie: movie, rating: 8.5, realm: self.realm)
			UserVO.updateUserVO(user: userVO, movie: movie, addRated: true, addWatchList: false, realm: self.realm)
			DispatchQueue.main.async {
				self.mView?.handleRateBtn(enable: false)
				self.mView?.setRateBtnImage(image: #imageLiteral(resourceName: "icons8-thumb_up_filled"))
				self.mView?.displayAlert(title: "Rated Movie", message:  response.status_message ?? "")
			}
		}
	}
	
	func onClickWatchedList() {
		if NetworkUtils.checkReachable() == false {
			self.mView?.displayAlert(title: "Error", message: "No Internet Connection!")
			return
		}
		guard let sessionId = UserDefaults.standard.string(forKey: DEFAULT_SESSION_ID) else {
			self.mView?.displayAlert(title: "Please Enter Login", message: "")
			return
			
		}
		let accountId = UserDefaults.standard.integer(forKey: DEFAULT_ACCOUNT_ID)
		UserModelImpl.shared.addToWatchListFromApi(movieId: movieId, session_id: sessionId,account_id: accountId) { (response) in
			guard let userVO = UserVO.getUserById(accountId: accountId, realm: self.realm) else {return}
			guard let movie = MovieVO.getMovieById(movieId: self.movieId, realm: self.realm) else {return}
			UserVO.updateUserVO(user: userVO, movie: movie, addRated: false, addWatchList: true, realm: self.realm)
			DispatchQueue.main.async {
				self.mView?.handleAddBtn(enable: false)
				self.mView?.displayAlert(title: "Added to watch list", message: response.status_message ?? "")
			}
		}
	}
	
	
	func onClickPlayMovie() {
		if NetworkUtils.checkReachable() == false {
			self.mView?.displayAlert(title: "Error", message: "No Internet Connection!")
		}else {
			self.mView?.showTrailerMovie()
		}
	}
	
	
}
