//
//  MainViewController.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 20.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

	// MARK: Properties
	private let searchController = UISearchController(searchResultsController: nil)

	var isSectionMovie: Bool = true
	var isSearchBarEmpty: Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}

	var filteredMoviePersonModel: [MoviePersonModel] = []
	let networkManager = NetworkManager()
	var moviePersonModel = [MoviePersonModel]()

	var isFiltering: Bool {
		return searchController.isActive && !isSearchBarEmpty
	}

	var layoutableView: MainView {
		guard let mainView = view as? MainView else {
			fatalError("view property has not been initialized yet, or not initialized as \(MainView.self).")
		}
		return mainView
	}

	var state: State = .loading {
		didSet {
			switch state {
			case .loading:
				layoutableView.showActivityIndicator()
				layoutableView.showEmptyView(isHidden: true)
			case .ready:
				layoutableView.hideActivityIndicator()
				layoutableView.showEmptyView(isHidden: true)
				layoutableView.tableView.reloadData()
			case .empty:
				layoutableView.showEmptyView(isHidden: false)
			}
		}
	}

	override func loadView() {
		view = MainView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}

	private func setupView() {
		setupSearchBar()
		setupTableView()
		fetchPopularMovies(page: 1)
		setupSegmentedControl()
	}

}

// MARK: Configure TableView, SearchBar
extension MainViewController {
	private func setupSearchBar() {
		layoutableView.tableView.tableHeaderView = searchController.searchBar
		searchController.searchBar.placeholder = "Search..."
		searchController.searchBar.tintColor = UIColor.black
		searchController.searchBar.barTintColor = .white
		navigationItem.title = "Popular Movies"
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		definesPresentationContext = true
		layoutableView.tableView.setContentOffset(CGPoint(x: 0, y: self.searchController.searchBar.frame.size.height), animated: false)
	}

	private func setupTableView() {
		layoutableView.tableView.delegate = self
		layoutableView.tableView.dataSource = self
		layoutableView.tableView.rowHeight = 150
		layoutableView.tableView.register(CommonCell.self, forCellReuseIdentifier: "CommonCell")
	}
}
