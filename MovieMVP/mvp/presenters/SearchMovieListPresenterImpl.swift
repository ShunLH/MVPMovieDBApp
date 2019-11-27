//
//  SearchMovieListPresenterImpl.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
import RealmSwift
class SearchMovieListPresenterImpl: BasePresenter {
	var searchedResult = [MovieInfoResponse]()
	let realm  = try! Realm()
	var mView : SearchMovieListView? = nil

	func onUIReady() {
		
	}
	
}

extension SearchMovieListPresenterImpl : SearchMovieListPresenter {
	func attchView(view: SearchMovieListView) {
		self.mView = view
	}
	
	
	
	func onClickSearch(movieName : String) {
		self.mView?.displayLoading()
		RemoteModelImpl.shared.fetchMoviesByNameFromApi(movieName: movieName, success: { [weak self] results in
			DispatchQueue.main.async {
				if results.isEmpty {
					self?.mView?.displayAlert(title: "No Movie", message: "No movie found with name \(movieName)")
					self?.mView?.dismissLoading()
					return
				}
				self?.searchedResult = results
				results.forEach({ [weak self] (movieInfo) in
					
					MovieInfoResponse.saveMovie(data: movieInfo, realm: self!.realm,catgory: nil)
				})
				
				self?.mView?.displaySearchedMovies()
				self?.mView?.dismissLoading()

			}
		}) { (error) in
			print(error)
			self.mView?.dismissLoading()

		}
	}
	
	func onClickSearchCancel() {
		self.mView?.dismissSearchView()
		
	}
	
	
}
