//
//  HomePresenterImpl.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 10/13/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
import RealmSwift

class HomePresenterImpl : BasePresenter {
	var mView : HomeView? = nil
	var realm : Realm!
	var categories : [Category] {
		return Category.allCases
		
	}
	// MARK: Private Funtions
	fileprivate func initGenreListFetchRequest() {
		let genres = realm.objects(MovieGenreVO.self)
		if genres.isEmpty {
			if NetworkUtils.checkReachable() == false {
				print("No Internet connection")
				return
			}
			RemoteModelImpl.shared.fetchMovieGenresFromApi(success: { (genres) in
				genres.forEach { [weak self] genre in
					DispatchQueue.main.async {
						MovieGenreResponse.saveMovieGenre(data: genre, realm: self!.realm)
					}
				}
			}) { (error) in
				print(error)
			}
		}
	}
	fileprivate func initMovieListFetchRequest() {
		let nowPlayingList = MovieVO.getMovieByCategory(category: Category.NowPlaying, realm: realm)
		if nowPlayingList == nil || nowPlayingList!.isEmpty {
			self.mView?.displayLoading()
			fetchNowPlayingMovies()
		}
		let popularList = MovieVO.getMovieByCategory(category: Category.Popular, realm: realm)
		if popularList == nil || popularList!.isEmpty {
			self.mView?.displayLoading()
			fetchPopularMovies()
		}
		let topRatedList = MovieVO.getMovieByCategory(category: Category.TopRated, realm: realm)
		if topRatedList == nil || topRatedList!.isEmpty {
			self.mView?.displayLoading()
			fetchTopRatedMovies()
		}
		let upcomingList = MovieVO.getMovieByCategory(category: Category.Upcoming, realm: realm)
		if upcomingList == nil || upcomingList!.isEmpty {
			self.mView?.displayLoading()
			fetchUpcomingMovies()
		}
		self.mView?.displayData()
	}
	
	fileprivate func fetchNowPlayingMovies() {
		if NetworkUtils.checkReachable() == false {
			print("No Internet connection")
			self.mView?.displayAlert(title: "Error", message: "No Internet Connection!")
			return
		}
		for index in 0...2 {
			RemoteModelImpl.shared.fetchNowPlayingMoviesFromApi(pageId: index, success: { (movies) in
				DispatchQueue.main.async { [weak self] in
					movies.forEach { movie in
						MovieInfoResponse.saveMovie(data: movie, realm: self!.realm,catgory: Category.NowPlaying)
					}
					let indexPath = IndexPath(row: 0, section: 0)
					self?.mView?.reloadTableView(atIndexPath: indexPath)
					self?.mView?.dismissLoading()
					self?.mView?.dismissRefreshControl()
				}
			}) { (error) in
				print(error)
			}
		}
		
	}
	
	fileprivate func fetchPopularMovies() {
		if NetworkUtils.checkReachable() == false {
			print("No Internet connection")
			return
		}
		for index in 0...2 {
			RemoteModelImpl.shared.fetchPopularMoviesFromApi(pageId: index, success: { (movies) in
				DispatchQueue.main.async { [weak self] in
					
					movies.forEach{ movie in
						MovieInfoResponse.saveMovie(data: movie, realm: self!.realm,catgory: Category.Popular)
					}
					print("saving....Popular")
					let indexPath = IndexPath(row: 0, section: 1)
					self?.mView?.reloadTableView(atIndexPath: indexPath)
					self?.mView?.dismissLoading()
					self?.mView?.dismissRefreshControl()
				}
			}) { (error) in
				print(error)
				
			}
		}
		
	}
	fileprivate func fetchUpcomingMovies() {
		if NetworkUtils.checkReachable() == false {
			print("No Internet connection")
			return
		}
		for index in 0...2 {
			RemoteModelImpl.shared.fetchUpcomingMoviesFromApi(pageId: index, success: { (movies) in
				DispatchQueue.main.async { [weak self] in
					
					movies.forEach{ movie in
						MovieInfoResponse.saveMovie(data: movie, realm: self!.realm,catgory: Category.Upcoming)
					}
					let indexPath = IndexPath(row: 0, section: 3)
					self?.mView?.reloadTableView(atIndexPath: indexPath)
					self?.mView?.dismissLoading()
					self?.mView?.dismissRefreshControl()
					
				}
			}) { (error) in
				print(error)
				
			}
		}
	}
	
	
	fileprivate func fetchTopRatedMovies() {
		if NetworkUtils.checkReachable() == false {
			print("No Internet connection")
			return
		}
		for index in 0...2 {
			RemoteModelImpl.shared.fetchTopRatedMoviesFromApi(pageId: index, success: { (movies) in
				DispatchQueue.main.async { [weak self] in
					
					movies.forEach{ movie in
						MovieInfoResponse.saveMovie(data: movie, realm: self!.realm,catgory: Category.TopRated)
					}
					let indexPath = IndexPath(row: 0, section: 2)
					self?.mView?.reloadTableView(atIndexPath: indexPath)
					self?.mView?.dismissLoading()
					self?.mView?.dismissRefreshControl()
					
				}
			}) { (error) in
				print(error)
			}
		}
	}
}
// MARK: Implementation HomePresenter
extension HomePresenterImpl : HomePresenter {
	func onClickMovieDetail(movieId: Int) {
		mView?.showMovieDetail(movieId: movieId)
	}
	
	func onUIReady() {
		realm = try! Realm()
		initGenreListFetchRequest()
		initMovieListFetchRequest()
	}
	
	func attachView(view: HomeView) {
		mView = view
	}
	func onHandleRefreshControl() {
		categories.forEach { (category) in
			if let movieList = MovieVO.getMovieByCategory(category: category, realm: realm){
				try? realm.write {
					realm.delete(movieList)
				}
			}
		}
		fetchNowPlayingMovies()
		fetchPopularMovies()
		fetchTopRatedMovies()
		fetchUpcomingMovies()
	}
	
	func getMovieListByCategory(category : Category) -> Results<MovieVO>?{
		let mvList = MovieVO.getMovieByCategory(category: category, realm: realm)
		return mvList
	}
	
}
