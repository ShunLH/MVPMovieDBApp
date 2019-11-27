//
//  RemoteModel.swift
//  MovieDBApp
//
//  Created by AcePlus Admin on 10/18/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation


protocol RemoteModel {
	
	func fetchMovieVideosFromApi(movieId : Int, success : @escaping ([Trailer]) -> Void,failure:@escaping(String)->Void)
	func fetchMoviesByNameFromApi(movieName : String, success : @escaping ([MovieInfoResponse]) -> Void,failure:@escaping(String)->Void)
	func fetchMovieDetailsFromApi(movieId : Int, success: @escaping (MovieDetailResponse) -> Void,failure:@escaping(String)->Void)
	func fetchSimilarMoviesFromApi(movieId : Int,pageId : Int, success : @escaping ([MovieInfoResponse]) -> Void,failure:@escaping(String)->Void)
	func fetchNowPlayingMoviesFromApi(pageId : Int, success: @escaping([MovieInfoResponse])->Void,failure:@escaping(String)->Void)
	func fetchTopRatedMoviesFromApi(pageId : Int, success : @escaping ([MovieInfoResponse]) -> Void,failure:@escaping(String)->Void)
	func fetchPopularMoviesFromApi(pageId : Int, success : @escaping ([MovieInfoResponse]) -> Void,failure:@escaping(String)->Void)
	func fetchUpcomingMoviesFromApi(pageId : Int, success : @escaping ([MovieInfoResponse]) -> Void,failure:@escaping(String)->Void)
	func fetchMovieGenresFromApi(success : @escaping([MovieGenreResponse]) -> Void,failure:@escaping(String)->Void)
}
