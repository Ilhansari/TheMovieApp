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
	private var layoutableView: CastDetailView {
		guard let castDetailView = view as? CastDetailView else {
			fatalError("view property has not been initialized yet, or not initialized as CastDetailView.")
		}
		return castDetailView
	}

	// MARK: Properties
	private let networkManager = NetworkManager()
	private var castDetailModel = [CastDetail]()
	private var movieId: Int?

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

// MARK: Networking
extension CastDetailViewController {
	func fetchCastDetails() {
		guard let id = self.movieId else { return }
		networkManager.getMovieCastDetails(movieId: id) { [weak self] castResponse in
			guard let self = self else { return }
			self.castDetailModel.append(contentsOf: castResponse.cast)
			self.layoutableView.tableView.reloadData()
		}
	}
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension CastDetailViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return castDetailModel.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as? CommonCell else { fatalError("Unable to dequeue cell") }
		cell.configure(model: castDetailModel[indexPath.row])
		return cell
	}
}
