//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {

	// MARK: view as a `Layoutable`
	private var layoutableView: MovieDetailView {
		guard let movieDetailView = view as? MovieDetailView else {
			fatalError("view property has not been initialized yet, or not initialized as \(MovieDetailView.self).")
		}
		return movieDetailView
	}

	// MARK: Properties
	private var movieId: Int
	private var networkManager: NetworkManager
	private var videoKey: String?

	override func loadView() {
		view = MovieDetailView()
	}

	init(movieId: Int, networkManager: NetworkManager) {
		self.movieId = movieId
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
		fetchMovieDetail(movieId: movieId)
		fetchMovieVideos()

		layoutableView.castDetailButton.addTarget(self, action: #selector(didTapCastDetails), for: .touchUpInside)
		layoutableView.trailerButton.addTarget(self, action: #selector(didTapVideoTrailer), for: .touchUpInside)

		self.edgesForExtendedLayout = []
	}
}

// MARK: Networking
extension MovieDetailViewController {
	private func fetchMovieDetail(movieId: Int) {
		layoutableView.showActivityIndicator()
		networkManager.getMovieDetails(movieId: movieId) { result in
			self.layoutableView.hideActivityIndicator()
			self.layoutableView.configureView(result)
		}
	}

	private func fetchMovieVideos() {
		layoutableView.showActivityIndicator()
		networkManager.getMovieVideos(movieId: movieId) { response in
			self.layoutableView.hideActivityIndicator()
			for videoKey in response.results {
				self.videoKey = videoKey.key
			}
		}
	}
}

// MARK: Actions
extension MovieDetailViewController {
	@objc func didTapCastDetails() {
		let castDetailViewController = CastDetailViewController(movieId: movieId)
		self.navigationController?.pushViewController(castDetailViewController, animated: true)
	}

	@objc func didTapVideoTrailer() {
		guard let videoKey = self.videoKey else {
			return
		}
		loadYoutube(videoKey: videoKey)
	}
}

// MARK: Setup Video Movies Trailer
extension MovieDetailViewController {
	private func loadYoutube(videoKey: String) {

		guard  let appURL = URL(string: "youtube://www.youtube.com/watch?v=\(videoKey)"),
			let webURL = URL(string: "https://www.youtube.com/watch?v=\(videoKey)")
			else { return }

		let application = UIApplication.shared

		if application.canOpenURL(appURL) {
			application.open(appURL)
		} else {
			application.open(webURL)
		}
	}
}
