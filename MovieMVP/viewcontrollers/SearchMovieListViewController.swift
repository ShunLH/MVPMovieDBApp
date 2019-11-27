//
//  SearchMovieListViewController.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import UIKit
import RealmSwift

class SearchMovieListViewController: UIViewController {
	let searchController = UISearchController(searchResultsController: nil)
	
	@IBOutlet weak var collectionViewSearchMovieList : UICollectionView!
	
	
	static var identifier : String {
		return String(describing: self)
	}
	var realm = try! Realm()
	var mPresenter : SearchMovieListPresenterImpl = SearchMovieListPresenterImpl()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionViewSearchMovieList.delegate = self
		collectionViewSearchMovieList.dataSource = self
		initView()
		
	}
	
	fileprivate func initView() {
		
		mPresenter.onUIReady()
		mPresenter.attchView(view: self)

		// Setup the Search Controller
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Eg: Avengers"
		
		navigationItem.searchController = searchController
		navigationItem.largeTitleDisplayMode = .always
		definesPresentationContext = true
		
		// Setup the Scope Bar
		searchController.searchBar.delegate = self
		searchController.searchBar.barStyle = .black
		
		//initialize collectionView 
		
		collectionViewSearchMovieList.dataSource = self
		collectionViewSearchMovieList.delegate = self
		
		
		
	}
	
}

extension SearchMovieListViewController : UISearchBarDelegate {
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		let searchedMovie = searchBar.text ?? ""
		mPresenter.onClickSearch(movieName: searchedMovie)
		
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		mPresenter.onClickSearchCancel()
	}
}
// MARK: CollectionView

extension SearchMovieListViewController : UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.mPresenter.searchedResult.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieItemCollectionViewCell.identifier, for: indexPath) as? MovieItemCollectionViewCell else {
			return UICollectionViewCell()
		}
		let movieVO = MovieInfoResponse.convertToMovieVO(data: self.mPresenter.searchedResult[indexPath.row], realm: realm)
		cell.data = movieVO
		
		return cell
	}
	
	
}
extension SearchMovieListViewController : UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (collectionView.bounds.width / 3) - 10;
		return CGSize(width: width, height: width * 1.45)
	}
}
extension SearchMovieListViewController : UICollectionViewDelegate {
	
}
// MARK: SearchMovieListView
extension SearchMovieListViewController : SearchMovieListView {
	func displayLoading() {
		showIndicatior("Loading...")
		
	}
	func dismissLoading() {
		self.hideIndicator()
	}
	func displaySearchedMovies() {
		collectionViewSearchMovieList.reloadData()
	}
	
	func dismissSearchView() {
		self.searchController.searchBar.endEditing(true)
		self.hideIndicator()
	}
	
	
}
