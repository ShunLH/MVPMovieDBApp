//
//  SharedApiClient.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 10/19/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
class ShareApiClient : BaseApiClient {
	//MARK: - Prpoerties
	static let shared = ShareApiClient()
	
	// Initialization
	private override init() {}
}
extension ShareApiClient : IApiClient {
	//MARK: For Movie Model ApiClient

	func fetchMovieVideos(movieId: Int, success: @escaping ([Trailer]) -> Void, failure: @escaping (String) -> Void) {
		self.requestApiWithoutHeaders(url: "\(Routes.ROUTE_MOVIE)/\(movieId)/videos?api_key=\(API.KEY)", method: .get, params: [:], success: { (response) in
			let apiResponse : VideoListResponse? = self.responseHandler(data: response)
			if let data = apiResponse {
				success(data.results)
			}
		}) { (error) in
			failure(error)
		}

	}
	
	func fetchMoviesByName(movieName: String, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		let route = "\(Routes.ROUTE_SEACRH_MOVIES)?api_key=\(API.KEY)&query=\(movieName.replacingOccurrences(of: " ", with: "%20"))"
		self.requestApiWithoutHeaders(url: route, method: .get, params: [:], success: { (response) in
			let apiResponse : MovieListResponse? = self.responseHandler(data: response)
			if let data = apiResponse {
				success(data.results)
			}
		}) { (error) in
			failure(error)
		}
	}
	
	func fetchMovieDetails(movieId: Int, success: @escaping (MovieDetailResponse) -> Void,failure: @escaping (String) -> Void) {
		self.requestApiWithoutHeaders(url: "\(Routes.ROUTE_MOVIE)/\(movieId)?api_key=\(API.KEY)", method: .get, params: [:], success: { (response) in
			let apiResponse : MovieDetailResponse? = self.responseHandler(data: response)
			if let data = apiResponse {
				success(data)
			}
		}) { (error) in
			failure(error)
		}

	}
	
	func fetchSimilarMovies(movieId: Int, pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		print("route = \(Routes.ROUTE_MOVIE)/\(movieId)/similar?api_key=\(API.KEY)&page=\(pageId)")
		self.requestApiWithoutHeaders(url: "\(Routes.ROUTE_MOVIE)/\(movieId)/similar?api_key=\(API.KEY)&page=\(pageId)", method: .get, params: [:], success: { (response) in
			let apiResponse : MovieListResponse? = self.responseHandler(data: response)
			if let data = apiResponse {
				success(data.results)
			}
		}) { (error) in
			failure(error)
		}
		
	}
	
	func fetchNowPlayingMovies(pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		print("url\(Routes.ROUTE_NOW_PLAYING_MOVIES)&page=\(pageId)")
		self.requestApiWithoutHeaders(url: "\(Routes.ROUTE_NOW_PLAYING_MOVIES)&page=\(pageId)", method: .get, params: [:], success: { (response) in
			let apiResponse : MovieListResponse? = self.responseHandler(data: response)
			if let data = apiResponse {
				success(data.results)
			}
		}) { (error) in
			failure(error)
		}
		
	}
	
	func fetchTopRatedMovies(pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		print("url = \(Routes.ROUTE_TOP_RATED_MOVIES)&page=\(pageId)")
		self.requestApiWithoutHeaders(url: "\(Routes.ROUTE_TOP_RATED_MOVIES)&page=\(pageId)", method: .get, params: [:], success: { (response) in
			let apiResponse : MovieListResponse? = self.responseHandler(data: response)
			if let data = apiResponse {
				success(data.results)
			}
		}) { (error) in
			failure(error)
		}
		
	}
	
	func fetchPopularMovies(pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		print("url = \(Routes.ROUTE_POPULAR_MOVIES)&page=\(pageId)")
		self.requestApiWithoutHeaders(url: "\(Routes.ROUTE_POPULAR_MOVIES)&page=\(pageId)", method: .get, params: [:], success: { (response) in
			let apiResponse : MovieListResponse? = self.responseHandler(data: response)
			if let data = apiResponse {
				success(data.results)
			}
		}) { (error) in
			failure(error)
		}

	}
	
	func fetchUpcomingMovies(pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		print("url = \(Routes.ROUTE_UPCOMING_MOVIES)&page=\(pageId)")
		self.requestApiWithoutHeaders(url: "\(Routes.ROUTE_UPCOMING_MOVIES)&page=\(pageId)", method: .get, params: [:], success: { (response) in
			let apiResponse : MovieListResponse? = self.responseHandler(data: response)
			if let data = apiResponse {
				success(data.results)
			}
		}) { (error) in
			failure(error)
		}

	}
	
	func fetchMovieGenres(success: @escaping ([MovieGenreResponse]) -> Void, failure: @escaping (String) -> Void) {
		print("url = \(Routes.ROUTE_MOVIE_GENRES)")
		self.requestApiWithoutHeaders(url: Routes.ROUTE_MOVIE_GENRES, method: .get, params: [:], success: { (response) in
			let apiResponse : MovieGenreListResponse? = self.responseHandler(data: response)
			if let data = apiResponse {
				success(data.genres)
			}
		}) { (error) in
			failure(error)
		}

		
	}
	//MARK: For User Model ApiClient

	
	func fetchWatchMovies(session_id: String, accountId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		
	}
	
	func fetchRatedMovies(session_id: String, accountId: Int, success: @escaping ([MovieInfoResponse]) -> Void) {
		
	}
	
	func addToWatchList(movieId: Int, session_id: String, account_id: Int, success: @escaping (StatusResponse) -> Void, failure: @escaping (String) -> Void) {
		
	}
	
	func addToRateMovies(movieId: Int, session_id: String, account_id: Int, success: @escaping (StatusResponse) -> Void, failure: @escaping (String) -> Void) {
		
	}
	
	func requestToken(success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
		
	}
	
	func createSession(token: String, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
		
	}
	
	func createSessionWithLogin(username: String, password: String, token: String, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
		
	}
	
	func getUserDetail(success: @escaping (LoginResponse) -> Void, failure: @escaping (String) -> Void) {
		
	}
	
	
}
