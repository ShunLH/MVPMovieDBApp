//
//  LoginViewPresenter.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
protocol LoginPresenter : BasePresenter{
	
	func attachView(view:LoginView)

	func onClickLoginBtn(username:String,password:String)
	
}
