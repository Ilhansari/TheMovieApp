//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieDetailViewController: UIViewController {

	// MARK: view as a `Layoutable`
	private var layoutableView: MovieDetailView {
		guard let movieDetailView = view as? MovieDetailView else {
			fatalError("view property has not been initialized yet, or not initialized as MovieDetailView.")
		}
		return movieDetailView
	}

	// MARK: Properties
	private var id: Int
	private var networkManager: NetworkManager
  private var movieDetailViewModel: MovieDetailViewModel!
  private var videoKey: String?

  private let disposeBag = DisposeBag()

	override func loadView() {
		view = MovieDetailView()
	}

	init(id: Int, networkManager: NetworkManager) {
		self.id = id
		self.networkManager = networkManager
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}

}

// MARK: Setup view and Target Buttons
extension MovieDetailViewController {
	private func setupView() {
    movieDetailViewModel = MovieDetailViewModel(networkManager: networkManager, id: id)

    movieDetailViewModel.isFetching.drive(self.layoutableView.activityIndicator.rx.isAnimating).disposed(by: disposeBag)

    movieDetailViewModel.movieDetail.drive(onNext: { [weak self] result in
      guard let self = self else { return }
      guard let result = result else { return }
      self.layoutableView.configureView(result)
      }).disposed(by: disposeBag)

    movieDetailViewModel.videoKey.drive(onNext: { [weak self] key in
      guard let self = self else { return }
      self.videoKey = key
    }).disposed(by: disposeBag)
    
		layoutableView.castDetailButton.addTarget(self, action: #selector(didTapCastDetails), for: .touchUpInside)
		layoutableView.trailerButton.addTarget(self, action: #selector(didTapVideoTrailer), for: .touchUpInside)

		self.edgesForExtendedLayout = []
	}
}

// MARK: Actions
extension MovieDetailViewController {
	@objc func didTapCastDetails() {
    let castDetailViewController = MovieCastDetailViewController(networkManager: networkManager, movieId: id)
		self.navigationController?.pushViewController(castDetailViewController, animated: true)
	}

	@objc func didTapVideoTrailer() {
    movieDetailViewModel.loadYoutube(videoKey: self.videoKey)
	}
}
