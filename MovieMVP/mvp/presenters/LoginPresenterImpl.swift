//
//  LoginPresenterImpl.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
class LoginPresenterImpl: BasePresenter {
	
	var mView : LoginView? = nil
	
	func onUIReady() {
		
	}
	
	
}
extension LoginPresenterImpl : LoginPresenter {
	
	func attachView(view: LoginView) {
		self.mView = view
	}
	
	func onClickLoginBtn(username:String,password:String) {
		if NetworkUtils.checkReachable() == false {
			self.mView?.displayAlert(title: "Error", message: "No Internet Connection!")
			return
		}
		if (username != "" && password != ""){
			mView?.displayLoading()
			UserModelImpl.shared.requestTokenFromApi{(token) in
				UserModelImpl.shared.createSessionWithLoginFromApi(username: username, password: password, token: token, success: {
					DispatchQueue.main.async {
						self.mView?.dismissLoading()
						self.mView?.showProfileView()
					}
				}) { (err) in
					print(err)
				}
			}
		}else {
			self.mView?.displayAlert(title: "Required", message: "Please enter username and password.")
		}
		
	}
	
}
