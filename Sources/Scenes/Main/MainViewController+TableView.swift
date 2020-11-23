//
//  MainView+TableView.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

//MARK: UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isFiltering {
			return moviePersonModel.count
		}
		return filteredMoviePersonModel.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as? CommonCell else {return UITableViewCell()}
		let moviePersonModel_: MoviePersonModel
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
			let movieDetailViewController = MovieDetailViewController(movieId: moviePersonId, networkManager: networkManager)
			self.navigationController?.pushViewController(movieDetailViewController, animated: true)
		} else {
			let personDetailViewController = PersonDetailViewController(personId: moviePersonId, networkManager: networkManager)
			self.navigationController?.pushViewController(personDetailViewController, animated: true)
		}
		tableView.deselectRow(at: indexPath, animated: false)
	}
}
