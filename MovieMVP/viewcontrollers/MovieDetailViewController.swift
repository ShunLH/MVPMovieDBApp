//
//  MovieDetailViewController.swift
//  MovieDBApp
//
//  Created by AcePlus Admin on 10/3/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift
class MovieDetailViewController: UIViewController {
	@IBOutlet weak var ivPoster : UIImageView!
	//	@IBOutlet weak var lblName : UILabel!
	@IBOutlet weak var lblAdult : UILabel!
	@IBOutlet weak var lblDuration : UILabel!
	@IBOutlet weak var lblOverview : UILabel!
	@IBOutlet weak var lblMore : UILabel!
	@IBOutlet weak var btnPlay : UIButton!
	@IBOutlet weak var btnAddList: UIButton!
	@IBOutlet weak var btnRate: UIButton!
	@IBOutlet weak var collectionViewSimilarMovieList : UICollectionView!
	static var identifier : String {
		return String(describing : self)
	}
	var movieId : Int = -1
	var mPresenter : MovieDetailPresenterImpl?
	let realm = try! Realm()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mPresenter = MovieDetailPresenterImpl(movieID: movieId)
		mPresenter?.attachView(view: self)
		mPresenter?.onUIReady()

		collectionViewSimilarMovieList.delegate = self
		collectionViewSimilarMovieList.dataSource = self
		
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	
	@IBAction func onClickPlayMovie(_ sender: Any) {
		mPresenter?.onClickPlayMovie()

	}
	
	@IBAction func clickOnRateBtn(_ sender: UIButton) {
		mPresenter?.onClickRateBth()
	}
	
	@IBAction func clickOnWatchList(_ sender: Any) {
		mPresenter?.onClickWatchedList()
	}
	
}
// MARK: CollectionView
extension MovieDetailViewController : UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.mPresenter?.similarMoviesResults.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieItemCollectionViewCell.identifier, for: indexPath) as? MovieItemCollectionViewCell else {
			return UICollectionViewCell()
		}
		let movieVO = MovieInfoResponse.convertToMovieVO(data: (self.mPresenter?.similarMoviesResults[indexPath.row])!, realm: realm)
		cell.data = movieVO
		return cell
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let desVC = segue.destination as? YTPlayerViewController {
			desVC.key = self.mPresenter?.trailerList?[0].key
		}
	}
	
	
}
extension MovieDetailViewController : UICollectionViewDelegate { }

// MARK: MovieDetailView
extension MovieDetailViewController : MovieDetailView {
	func displayInitData() {
		lblOverview.text = self.mPresenter?.movie.overview
		ivPoster?.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(self.mPresenter?.movie.poster_path ?? "")"), placeholderImage: #imageLiteral(resourceName: "icons8-movie"), completed: nil)
	}
	
	func displayMovieDetail() {
		lblAdult.text = (mPresenter?.movieDetail?.adult ?? false) ? "18 +" : " "
		if let urlStr = mPresenter?.movieDetail?.poster_path {
			ivPoster?.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(urlStr)"), placeholderImage: #imageLiteral(resourceName: "icons8-movie"), completed: nil)
		}
		if let duration =  mPresenter?.movieDetail?.runtime {
			let hr : Int = duration/60
			let min : Int = duration%60
			lblDuration.text = "\(hr == 0 ? "":"\(hr)") hour : \(min) min"
			lblOverview.text =  mPresenter?.movieDetail?.overview
			lblMore.text = "MORE LIKE THIS"
		}
	}
	
	func displaySimilarMovies() {
		collectionViewSimilarMovieList.reloadData()
	}
	
	func handleRateBtn(enable: Bool) {
		btnRate.isEnabled = enable
	}
	
	func handleAddBtn(enable: Bool) {
		btnAddList.isEnabled = enable
	}
	
	func setRateBtnImage(image: UIImage) {
		btnRate.setImage(image, for: .normal)
	}
	
	func displayLoading() {
		showIndicatior("Loading")
	}
	
	func dismissLoading() {
		hideIndicator()
	}
	
	func displayAlert(title: String, message: String) {
		Dialog.showAlert(viewController: self, title: title, message: message)
	}
	func showTrailerMovie(){
		performSegue(withIdentifier: "sb-segue-ytPlayer", sender: self)

	}
	
	
	
}
