//
//  MainView+Networking.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

extension MainViewController {
	func fetchPopularMovies(page: Int) {
		state = .loading
		moviePersonModel = []
		networkManager.getPopularMoviesList(page: page) { moviesResponse in
			self.state = .ready
			self.moviePersonModel.append(contentsOf: moviesResponse.results)
			self.filteredMoviePersonModel = self.moviePersonModel
			self.layoutableView.tableView.reloadData()
		}
	}

	func fetchPopularPerson() {
		state = .loading
		moviePersonModel = []
		networkManager.getPopularPersonList { personResponse in
			self.state = .ready
			self.moviePersonModel.append(contentsOf: personResponse.results)
			self.filteredMoviePersonModel = self.moviePersonModel
			self.layoutableView.tableView.reloadData()
		}
	}

}
