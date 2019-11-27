//
//  UserModel.swift
//  MovieDBApp
//
//  Created by AcePlus Admin on 10/18/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation

protocol UserModel {
	func fetchWatchMoviesFromApi(session_id : String, accountId : Int, completion : @escaping ([MovieInfoResponse]) -> Void)
	func fetchRatedMoviesFromApi(session_id : String, accountId : Int, completion : @escaping ([MovieInfoResponse]) -> Void)
	func addToWatchListFromApi(movieId : Int , session_id : String,account_id : Int,completion : @escaping (StatusResponse) -> Void)
	func addToRateMoviesFromApi(movieId : Int , session_id : String,account_id : Int,completion : @escaping (StatusResponse) -> Void)
	func requestTokenFromApi(completion :@escaping(String) -> Void)
	func createSessionFromApi(token: String,success :@escaping() -> Void,failure :@escaping(String) -> Void)
	func createSessionWithLoginFromApi(username:String,password:String,token:String,success :@escaping() -> Void,failure :@escaping(String) -> Void)
	func getUserDetailFromApi(success :@escaping(LoginResponse) -> Void,failure :@escaping(String) -> Void)
}
