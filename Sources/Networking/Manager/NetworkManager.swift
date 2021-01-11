//
//  NetworkManager.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

final class DefaultDecoder: JSONDecoder {
	override init() {
		super.init()
		keyDecodingStrategy = .convertFromSnakeCase
	}
}

protocol NetworkProtocol {
  func getPopularMoviesList(page: Int, completionHandler: @escaping (MoviePersonResponse) -> Void)
	func getMovieDetails(movieId: Int, completionHandler: @escaping (MovieDetail) -> Void)
	func getPopularPersonList(completionHandler: @escaping (MoviePersonResponse) -> Void)
	func getPersonDetails(personId: Int, completionHandler: @escaping (PersonDetails) -> Void)
	func searchMoviePerson(query: String, completionHandler: @escaping (MoviePersonResponse) -> Void)
	func getMovieCastDetails(movieId: Int, completionHandler: @escaping (CastResponse) -> Void)
	func getMovieVideos(movieId: Int, completionHandler: @escaping (MoviesVideoResponse) -> Void)
	func getPersonCastDetails(movieId: Int, completionHandler: @escaping (CastResponse) -> Void) 
}

class NetworkManager: UIViewController, NetworkProtocol {

  func getPopularMoviesList(page: Int, completionHandler: @escaping (MoviePersonResponse) -> Void) {
    API.moviesProvider.request(.getMostPopularMovieList(page: page)) { [weak self] result in

			guard let self = self else { return }
			
			switch result {

			case .success(let dataResponse):
				do {
					let movies = try dataResponse.map(MoviePersonResponse.self, using: DefaultDecoder())
					completionHandler(movies)

				} catch {
					self.showAlert(title: error.localizedDescription)
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription)
			}
		}
	}

	func getMovieDetails(movieId: Int, completionHandler: @escaping (MovieDetail) -> Void) {
		API.moviesProvider.request(.getMostPopularMovieListDetail(id: movieId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let movieDetail = try dataResponse.map(MovieDetail.self, using: DefaultDecoder())
					completionHandler(movieDetail)

				} catch {
					self.showAlert(title: error.localizedDescription)
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription )
			}
		}
	}

	func getMovieVideos(movieId: Int, completionHandler: @escaping (MoviesVideoResponse) -> Void) {
		API.moviesProvider.request(.getMovieVideos(id: movieId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let movieVideos = try dataResponse.map(MoviesVideoResponse.self, using: DefaultDecoder())
					completionHandler(movieVideos)

				} catch {
					self.showAlert(title: error.localizedDescription)
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription)
			}
		}
	}

	func getPopularPersonList(completionHandler: @escaping (MoviePersonResponse) -> Void) {
		API.moviesProvider.request(.getMostPopularPersonList) { [weak self] result in

			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let person = try dataResponse.map(MoviePersonResponse.self, using: DefaultDecoder())
					completionHandler(person)

				} catch {
					self.showAlert(title: error.localizedDescription)
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription )
			}
		}
	}

	func getPersonDetails(personId: Int, completionHandler: @escaping (PersonDetails) -> Void) {
		API.moviesProvider.request(.getMostPopularPersonListDetail(id: personId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let personDetails = try dataResponse.map(PersonDetails.self, using: DefaultDecoder())
					completionHandler(personDetails)

				} catch {
					self.showAlert(title: error.localizedDescription)
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription )
			}
		}
	}

	func searchMoviePerson(query: String, completionHandler: @escaping (MoviePersonResponse) -> Void) {
		API.moviesProvider.request(.getSearchMovie(query: query)) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let dataResponse):
				do {
					let movies = try dataResponse.map(MoviePersonResponse.self, using: DefaultDecoder())
					completionHandler(movies)

				} catch {
					self.showAlert(title: error.localizedDescription)
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription)
			}
		}
	}

	func getMovieCastDetails(movieId: Int, completionHandler: @escaping (CastResponse) -> Void) {
		API.moviesProvider.request(.getCastDetails(id: movieId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let castDetail = try dataResponse.map(CastResponse.self, using: DefaultDecoder())
					completionHandler(castDetail)

				} catch {
					self.showAlert(title: error.localizedDescription)
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription)
			}
		}
	}

	func getPersonCastDetails(movieId: Int, completionHandler: @escaping (CastResponse) -> Void) {
		API.moviesProvider.request(.getPersonCastCredits(id: movieId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let castDetail = try dataResponse.map(CastResponse.self, using: DefaultDecoder())
					completionHandler(castDetail)

				} catch {
					self.showAlert(title: error.localizedDescription)
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription)
			}
		}
	}
	
}
