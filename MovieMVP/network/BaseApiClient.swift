//
//  BaseApiClient.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 10/19/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
import Alamofire

open class BaseApiClient {
	
	// Function For Api Without Headers
	
	
	
	func requestApiWithoutHeaders (
		url : String,
		method : HTTPMethod,
		params: Parameters,
		success : @escaping(Data) -> Void,
		fail : @escaping(String) -> Void
	) {
		Alamofire.request(url,method: method,parameters: params,headers:[:]).responseJSON { response in
			switch response.result {
			case .success :
				success(response.data!)
			case .failure(let error) :
				debugPrint(error.localizedDescription)
				fail(error.localizedDescription)
				
			}
		}
	}
	
	
	func requestApiWithHeaders(
		url : String,
		method : HTTPMethod,
		params: Parameters,
		success : @escaping(Data) -> Void,
		fail : @escaping(String) -> Void
	){
		//		let headers : HTTPHeaders = ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: USER_DEF_TOKEN) ?? "")"]
		Alamofire.request(url,method: method,parameters: params,headers:[:]).responseJSON { response in
			switch response.result {
			case .success :
				success(response.data!)
			case .failure(let error) :
				debugPrint(error.localizedDescription)
				fail(error.localizedDescription)
				
			}
		}
	}
	
	func generateURL(route:String) -> String {
		return API.BASE_URL + route
	}
	
	func responseHandler<T : Decodable>(data : Data) -> T? {
		let TAG = String(describing: T.self)
		
		
		if let result = try? JSONDecoder().decode(T.self, from: data) {
			return result
		} else {
			print("\(TAG): failed to parse data")
			return nil
		}
	}
}
