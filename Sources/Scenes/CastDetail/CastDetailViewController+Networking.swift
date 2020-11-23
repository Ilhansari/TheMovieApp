//
//  CastDetailViewController+Networking.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

//MARK: Networking
extension CastDetailViewController {
	 func fetchCastDetails() {
		guard let id = self.movieId else { return }
		networkManager.getMovieCastDetails(movieId: id) { castResponse in
			self.castDetailModel.append(contentsOf: castResponse.cast)
			self.layoutableView.tableView.reloadData()
		}
	}
}
