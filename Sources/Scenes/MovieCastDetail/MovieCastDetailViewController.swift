//
//  CastDetailViewController.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieCastDetailViewController: UIViewController {

	// MARK: view as a `Layoutable`
	private var layoutableView: MovieCastDetailView {
		guard let movieCastDetailView = view as? MovieCastDetailView else {
			fatalError("view property has not been initialized yet, or not initialized as CastDetailView.")
		}
		return movieCastDetailView
	}

	// MARK: Properties
  private var networkManager: NetworkManager
	private var movieId: Int
  private var movieCastDetailViewModel: MovieCastDetailViewModel!

  private let disposeBag = DisposeBag()

	override func loadView() {
		view = MovieCastDetailView()
	}

  init(networkManager: NetworkManager, movieId: Int) {
		self.movieId = movieId
    self.networkManager = networkManager
    super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
    bindViewModel()
	}
}

// MARK: Configure TableView
extension MovieCastDetailViewController {
	private func setupTableView() {
		layoutableView.tableView.rowHeight = 153
		layoutableView.tableView.register(CommonCell.self, forCellReuseIdentifier: "CommonCell")
	}

  private func bindViewModel() {
    movieCastDetailViewModel = MovieCastDetailViewModel(networkManager: networkManager, id: movieId)

    movieCastDetailViewModel.isFetching.drive(self.layoutableView.activityIndicator.rx.isAnimating).disposed(by: disposeBag)

    movieCastDetailViewModel.movieCastDetail.drive { [weak self] _ in
      guard let self = self else { return }
      self.layoutableView.tableView.reloadData()
    }

    movieCastDetailViewModel.movieCastDetail.map { $0 }.asObservable().bind(to: self.layoutableView.tableView.rx.items(cellIdentifier: "CommonCell", cellType: CommonCell.self)) { (_, cast, cell) in
      cell.configure(model: cast)
    }.disposed(by: disposeBag)
  }
}
