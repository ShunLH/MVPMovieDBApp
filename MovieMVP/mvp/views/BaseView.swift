//
//  BaseView.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 10/13/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation

protocol BaseView {
	func displayLoading()
	func dismissLoading()
	func dismissRefreshControl()
	func displayAlert(title: String,message : String)


}
extension BaseView {
	func displayLoading(){
		
	}
	func dismissLoading(){
		
	}
	func dismissRefreshControl(){
		
	}
	func displayAlert(title: String,message : String) {
		
	}
}
