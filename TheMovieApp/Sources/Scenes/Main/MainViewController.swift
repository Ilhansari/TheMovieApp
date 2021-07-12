//
//  MainViewController.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 20.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

  private var layoutableView: MainView = {
    let viewSource = MainView()
    return viewSource
  }()

  // MARK: Properties
  private let searchController = UISearchController(searchResultsController: nil)

  private var isSectionMovie: Bool = true
  private var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }

  private var filteredMoviePersonModel: [MoviePerson] = []
  private let networkManager = NetworkManager()
  private var moviePersonModel = [MoviePerson]()

  private var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
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
    setupSearchBarController()
    setupTableView()
    fetchPopularMovies()
    setupSegmentedControl()
  }
}

// MARK: Configure TableView, SearchController
extension MainViewController {
  private func setupSearchBarController() {
    layoutableView.tableView.tableHeaderView = searchController.searchBar
    searchController.searchBar.placeholder = "Search.."
    searchController.searchBar.tintColor = UIColor.black
    searchController.searchBar.barTintColor = .white
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    definesPresentationContext = true
    navigationItem.title = "Popular Movies"
  }

  private func setupTableView() {
    layoutableView.tableView.delegate = self
    layoutableView.tableView.dataSource = self
    layoutableView.tableView.rowHeight = 150
  }
}

// MARK: UISearchViewControllerDelegate
extension MainViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    guard let text = searchBar.text else { return }
    filterContentForSearchText(text)
  }
}

// MARK: Filtering movie/person in Search Bar
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

// MARK: Networking
extension MainViewController {
  private func fetchPopularMovies() {
    state = .loading
    moviePersonModel = []
    networkManager.getPopularMoviesList { [weak self] moviesResponse in
      guard let self = self else { return }
      self.state = .ready
      self.moviePersonModel.append(contentsOf: moviesResponse.results)
      self.filteredMoviePersonModel = self.moviePersonModel
      self.layoutableView.tableView.reloadData()
    }
  }

  private func fetchPopularPerson() {
    state = .loading
    moviePersonModel = []
    networkManager.getPopularPersonList { [weak self] personResponse in
      guard let self = self else { return }
      self.state = .ready
      self.moviePersonModel.append(contentsOf: personResponse.results)
      self.filteredMoviePersonModel = self.moviePersonModel
      self.layoutableView.tableView.reloadData()
    }
  }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
      return moviePersonModel.count
    }
    return filteredMoviePersonModel.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as? CommonCell else { fatalError("Unable to dequeue cell")}
    let moviePersonModel_: MoviePerson
    if isFiltering {
      moviePersonModel_ = moviePersonModel[indexPath.row]
    } else {
      moviePersonModel_ = filteredMoviePersonModel[indexPath.row]
    }
    cell.configure(model: moviePersonModel_, isSectionMovie: isSectionMovie)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let moviePersonId = moviePersonModel[indexPath.row].id else { return }
    if isSectionMovie {
      let movieDetailViewController = MovieDetailViewController(id: moviePersonId, networkManager: networkManager)
      self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    } else {
      let personDetailViewController = PersonDetailViewController(personId: moviePersonId, networkManager: networkManager)
      self.navigationController?.pushViewController(personDetailViewController, animated: true)
    }
    tableView.deselectRow(at: indexPath, animated: false)
  }
}

// MARK: Setup Segmented Control
extension MainViewController {
  func setupSegmentedControl() {
    layoutableView.segmentedControl.addTarget(self, action: #selector(MainViewController.segmentedControlChanged(_:)), for: .valueChanged)
  }

  @objc  func segmentedControlChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      fetchPopularMovies()
      self.isSectionMovie = true
      navigationItem.title = "Popular Movies"
    case 1:
      fetchPopularPerson()
      self.isSectionMovie = false
      navigationItem.title = "Popular Actors"
    default:
      fetchPopularMovies()
      self.isSectionMovie = true
      navigationItem.title = "Popular Movies"
    }
  }
}