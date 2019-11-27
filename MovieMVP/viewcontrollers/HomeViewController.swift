//
//  ViewController.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 10/13/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
	
	@IBOutlet weak var tableViewMovieList : UITableView!
	var mPresenter : HomePresenterImpl = HomePresenterImpl()
	var selectedMovieId : Int = -1
	lazy var refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action:#selector(handleRefresh(_:)),for: .valueChanged)
		refreshControl.tintColor = UIColor.red
		return refreshControl
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		tableViewMovieList.delegate = self
		tableViewMovieList.dataSource = self
		tableViewMovieList.addSubview(refreshControl)
		mPresenter.attachView(view: self)
		mPresenter.onUIReady()
	}
	
	@objc func handleRefresh(_ refreshControl: UIRefreshControl) {
		mPresenter.onHandleRefreshControl()
	}
	
}

extension HomeViewController : UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return mPresenter.categories.count
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else {return UITableViewCell()}
		let key = mPresenter.categories[indexPath.section]
		cell.moviesList = mPresenter.getMovieListByCategory(category: key)
		cell.delegate = self
		return cell
	}
}

extension HomeViewController : UITableViewDelegate , MovieListTableViewCellDelegate{
	func showMovieDetail(movieID: Int) {
		mPresenter.onClickMovieDetail(movieId: movieID)
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return mPresenter.categories[section].rawValue
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? MovieDetailViewController {
			vc.movieId = selectedMovieId
		}
	}
}

extension HomeViewController : HomeView {
	func showMovieDetail(movieId: Int) {
		selectedMovieId = movieId
		performSegue(withIdentifier: "movie_detail_sb_segue", sender: self)
	}
	
	func displayData() {
		self.tableViewMovieList.reloadData()
	}
	
	func displayAlert(title: String, message: String) {
		Dialog.showAlert(viewController: self, title: title, message: message)
	}
	
	func reloadTableView(atIndexPath: IndexPath) {
		self.tableViewMovieList.reloadRows(at: [atIndexPath], with: .automatic)
	}
	
	func displayLoading() {
		self.showIndicatior("Loading")
	}
	
	func dismissLoading() {
		self.hideIndicator()
	}
	
	func dismissRefreshControl() {
		self.refreshControl.endRefreshing()
	}
	
	
}


