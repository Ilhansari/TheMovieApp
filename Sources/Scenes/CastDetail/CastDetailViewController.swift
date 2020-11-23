//
//  CastDetailViewController.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

final class CastDetailViewController: UIViewController {

	// MARK: view as a `Layoutable`
	var layoutableView: CastDetailView {
	guard let castDetailView = view as? CastDetailView else {
		fatalError("view property has not been initialized yet, or not initialized as \(CastDetailView.self).")
	}
	return castDetailView
}

	// MARK: Properties
	let networkManager = NetworkManager()
	var castDetailModel = [CastDetailModel]()
	var movieId: Int?

	override func loadView() {
		view = CastDetailView()
	}

	convenience init(movieId: Int) {
		self.init()
		self.movieId = movieId
	}

	override func viewDidLoad() {

		super.viewDidLoad()
		setupTableView()
		fetchCastDetails()
	}
}

// MARK: Configure TableView
extension CastDetailViewController {
	private func setupTableView() {
		layoutableView.tableView.delegate = self
		layoutableView.tableView.dataSource = self
		layoutableView.tableView.rowHeight = 153
		layoutableView.tableView.register(CommonCell.self, forCellReuseIdentifier: "CommonCell")
	}
}
