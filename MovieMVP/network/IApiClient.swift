//
//  IApiClient.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 10/19/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation

protocol IApiClient {
	//MARK: For MovieModel ApiClient

	func fetchMovieVideos(movieId : Int, success : @escaping ([Trailer]) -> Void,failure: @escaping(String)->Void)
	func fetchMoviesByName(movieName : String, success : @escaping ([MovieInfoResponse]) -> Void,failure: @escaping(String)->Void)
	func fetchMovieDetails(movieId : Int, success: @escaping (MovieDetailResponse) -> Void,failure: @escaping (String) -> Void)
	func fetchSimilarMovies(movieId : Int,pageId : Int, success : @escaping ([MovieInfoResponse]) -> Void,failure: @escaping(String)->Void)
	func fetchNowPlayingMovies(pageId : Int, success: @escaping([MovieInfoResponse])->Void,failure: @escaping(String)->Void)
	func fetchTopRatedMovies(pageId : Int, success : @escaping ([MovieInfoResponse]) -> Void,failure: @escaping(String)->Void)
	func fetchPopularMovies(pageId : Int, success : @escaping ([MovieInfoResponse]) -> Void,failure: @escaping(String)->Void)
	func fetchUpcomingMovies(pageId : Int, success : @escaping ([MovieInfoResponse]) -> Void,failure: @escaping(String)->Void)
	func fetchMovieGenres(success : @escaping([MovieGenreResponse]) -> Void,failure: @escaping(String)->Void)
	//MARK: For UserModel ApiClient
	func fetchWatchMovies(session_id : String, accountId : Int, success : @escaping ([MovieInfoResponse]) -> Void,failure: @escaping(String)->Void)
	func fetchRatedMovies(session_id : String, accountId : Int, success : @escaping ([MovieInfoResponse]) -> Void)
	func addToWatchList(movieId : Int , session_id : String,account_id : Int,success : @escaping (StatusResponse) -> Void,failure: @escaping(String)->Void)
	func addToRateMovies(movieId : Int , session_id : String,account_id : Int,success : @escaping (StatusResponse) -> Void,failure: @escaping(String)->Void)
	func requestToken(success :@escaping(String) -> Void,failure: @escaping(String)->Void)
	func createSession(token: String,success :@escaping() -> Void,failure :@escaping(String) -> Void)
	func createSessionWithLogin(username:String,password:String,token:String,success :@escaping() -> Void,failure :@escaping(String) -> Void)
	func getUserDetail(success :@escaping(LoginResponse) -> Void,failure :@escaping(String) -> Void)
}
