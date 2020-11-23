//
//  MovieDetailViewController+Actions.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

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
