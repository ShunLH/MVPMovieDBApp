//
//  ProfileViewController.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import UIKit
import RealmSwift
class ProfileViewController: UIViewController {
	
	@IBOutlet weak var lblName: UILabel!
	
	@IBOutlet weak var profileTableView: UITableView!
	var mPresenter : ProfilePresenterImpl = ProfilePresenterImpl()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		profileTableView.delegate = self
		profileTableView.dataSource = self
		mPresenter.attachView(view: self)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		mPresenter.onUIReady()
	}
	
	static var identifier : String {
		return String(describing: self)
	}
	
	@IBAction func clickOnLogout(_ sender: Any) {
		self.mPresenter.onClickLogout()
	}
	
}
extension ProfileViewController : UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else {return UITableViewCell()}
		switch indexPath.section {
		case 0 :
			cell.movieVOList = mPresenter.watchMoviesList
			break
		case 1 :
			cell.movieVOList = mPresenter.ratedMoviesList
			break
		default :
			break
		}
		cell.delegate = self
		return cell
	}
}

extension ProfileViewController : UITableViewDelegate , MovieListTableViewCellDelegate{
	func showMovieDetail(movieID: Int) {
		mPresenter.onClickMovieDetail(movieId: movieID)
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0 :
			return "Watch Movies List"
		case 1 :
			return "Rated Movies List"
			
		default :
			return ""
			
		}
		
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? MovieDetailViewController {
			vc.movieId = mPresenter.selectedMovieId
		}
	}
}

extension ProfileViewController : ProfileView {
	func showMovieDetail() {
		performSegue(withIdentifier: "movie_detail_sb_segue", sender: self)
	}
	
	
	func displayData() {
		self.lblName.text = mPresenter.userVO.userName
		self.profileTableView.reloadData()
		
	}
	
	func showLoginView() {
		self.tabBarController?.selectedIndex = 0
	}
	
	
}
