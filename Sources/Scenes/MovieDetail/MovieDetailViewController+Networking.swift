//
//  MovieDetailViewController+Networking.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

extension MovieDetailViewController {
	func fetchMovieDetail(movieId: Int) {
		layoutableView.showActivityIndicator()
		networkManager.getMovieDetails(movieId: movieId) { result in
			self.layoutableView.hideActivityIndicator()
			self.layoutableView.configureView(result)
		}
	}

	func fetchMovieVideos() {
		layoutableView.showActivityIndicator()
		networkManager.getMovieVideos(movieId: movieId) { response in
			self.layoutableView.hideActivityIndicator()
			for videoKey in response.results {
				self.videoKey = videoKey.key
			}
		}
	}
}
