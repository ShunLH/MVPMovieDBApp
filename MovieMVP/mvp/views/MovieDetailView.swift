//
//  MovieDetailView.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
import UIKit
protocol MovieDetailView : BaseView{
	func displayInitData()
	func displayMovieDetail()
	func displaySimilarMovies()
	func showTrailerMovie()
	func handleRateBtn(enable:Bool)
	func handleAddBtn(enable:Bool)
	func setRateBtnImage(image:UIImage)
	
}
