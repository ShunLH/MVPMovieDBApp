//
//  MovieModel.swift
//  MovieDBApp
//
//  Created by AcePlus Admin on 10/4/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
import RealmSwift

class RemoteModelImpl : BaseModel {
	static let shared = RemoteModelImpl()
	
	override private init() {}
	
	
	
}

extension RemoteModelImpl : RemoteModel {
	
	func fetchMovieVideosFromApi(movieId: Int, success: @escaping ([Trailer]) -> Void, failure: @escaping (String) -> Void) {
		ShareApiClient.shared.fetchMovieVideos(movieId: movieId, success: { (data) in
			success(data)
		}) { (error) in
			failure(error)
		}
		
	}
	
	func fetchMoviesByNameFromApi(movieName: String, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		ShareApiClient.shared.fetchMoviesByName(movieName: movieName, success: { (data) in
			success(data)
		}) { (error) in
			failure(error)
		}
		
	}
	
	func fetchMovieDetailsFromApi(movieId: Int, success: @escaping (MovieDetailResponse) -> Void, failure: @escaping(String) -> Void) {
		ShareApiClient.shared.fetchMovieDetails(movieId: movieId, success: { (data) in
			success(data)
		}) { (error) in
			failure(error)
		}
	}
	
	func fetchSimilarMoviesFromApi(movieId: Int, pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		ShareApiClient.shared.fetchSimilarMovies(movieId: movieId, pageId: pageId, success: { (data) in
			success(data)
		}) { (error) in
			failure(error)
		}
		
	}
	
	func fetchNowPlayingMoviesFromApi(pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		ShareApiClient.shared.fetchNowPlayingMovies(pageId: pageId, success: { (data) in
			success(data)
		}) { (error) in
			failure(error)
		}
		
	}
	
	func fetchTopRatedMoviesFromApi(pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		ShareApiClient.shared.fetchTopRatedMovies(pageId: pageId, success: { (data) in
			success(data)
		}) { (error) in
			failure(error)
		}
	}
	
	func fetchPopularMoviesFromApi(pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		ShareApiClient.shared.fetchPopularMovies(pageId: pageId, success: { (data) in
			success(data)
		}) { (error) in
			failure(error)
		}
		
	}
	
	func fetchUpcomingMoviesFromApi(pageId: Int, success: @escaping ([MovieInfoResponse]) -> Void, failure: @escaping (String) -> Void) {
		ShareApiClient.shared.fetchUpcomingMovies(pageId: pageId, success: { (data) in
			success(data)
		}) { (error) in
			failure(error)
		}
		
	}
	
	func fetchMovieGenresFromApi(success: @escaping ([MovieGenreResponse]) -> Void, failure: @escaping (String) -> Void) {
		ShareApiClient.shared.fetchMovieGenres(success: { (data) in
			success(data)
		}) { (error) in
			 debugPrint(error)
			failure(error)
		}
		
	}
	
	
	
	
	
}
