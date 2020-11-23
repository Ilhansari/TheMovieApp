//
//  MainView+Search.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

//MARK: UISearchViewControllerDelegate
extension MainViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		guard let text = searchBar.text else { return }
		filterContentForSearchText(text)
	}
}

//MARK: Filtering movie/person in Search Bar
extension MainViewController {
	func filterContentForSearchText(_ searchText: String) {
		if isSearchBarEmpty {
			self.layoutableView.tableView.reloadData()
			return
		}
		networkManager.searchMoviePerson(query: searchText) { response in
			if response.results.count <= 0 {
				self.state = .empty
			} else {
				self.state = .ready
			}
			self.moviePersonModel = response.results
			self.layoutableView.tableView.reloadData()
		}
	}
}
