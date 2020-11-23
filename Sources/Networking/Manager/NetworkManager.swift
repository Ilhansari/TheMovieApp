//
//  NetworkManager.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

protocol NetworkProtocol {
	func getPopularMoviesList(page: Int, completionHandler: @escaping (MoviePersonResponse) -> Void)
	func getMovieDetails(movieId: Int, completionHandler: @escaping (MovieDetailModel) -> Void)
	func getPopularPersonList(completionHandler: @escaping (MoviePersonResponse) -> Void)
	func getPersonDetails(personId: Int, completionHandler: @escaping (PersonDetailsModel) -> Void)
	func searchMoviePerson(query: String,  completionHandler: @escaping (MoviePersonResponse) -> Void)
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
					let movies = try dataResponse.map(MoviePersonResponse.self)
					completionHandler(movies)

				} catch {
					self.showAlert(title: error.localizedDescription, message: "")
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription ?? "", message: "")
			}
		}
	}

	func getMovieDetails(movieId: Int, completionHandler: @escaping (MovieDetailModel) -> Void) {
		API.moviesProvider.request(.getMostPopularMovieListDetail(id: movieId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let movieDetail = try dataResponse.map(MovieDetailModel.self)
					completionHandler(movieDetail)

				} catch {
					self.showAlert(title: error.localizedDescription, message: "")
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription ?? "", message: "")
			}
		}
	}

	func getMovieVideos(movieId: Int, completionHandler: @escaping (MoviesVideoResponse) -> Void) {
		API.moviesProvider.request(.getMovieVideos(id: movieId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let movieVideos = try dataResponse.map(MoviesVideoResponse.self)
					completionHandler(movieVideos)

				} catch {
					self.showAlert(title: error.localizedDescription, message: "")
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription ?? "", message: "")
			}
		}
	}

	func getPopularPersonList(completionHandler: @escaping (MoviePersonResponse) -> Void) {
		API.moviesProvider.request(.getMostPopularPersonList) { [weak self] result in

			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let person = try dataResponse.map(MoviePersonResponse.self)
					completionHandler(person)

				} catch {
					self.showAlert(title: error.localizedDescription, message: "")
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription ?? "", message: "")
			}
		}
	}

	func getPersonDetails(personId: Int, completionHandler: @escaping (PersonDetailsModel) -> Void) {
		API.moviesProvider.request(.getMostPopularPersonListDetail(id: personId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let personDetails = try dataResponse.map(PersonDetailsModel.self)
					completionHandler(personDetails)

				} catch {
					self.showAlert(title: error.localizedDescription, message: "")
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription ?? "", message: "")
			}
		}
	}

	func searchMoviePerson(query: String, completionHandler: @escaping (MoviePersonResponse) -> Void) {
		API.moviesProvider.request(.getSearchMovie(query: query)) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let dataResponse):
				do {
					let movies = try dataResponse.map(MoviePersonResponse.self)
					completionHandler(movies)

				} catch {
					self.showAlert(title: error.localizedDescription, message: "")
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription ?? "", message: "")
			}
		}
	}

	func getMovieCastDetails(movieId: Int, completionHandler: @escaping (CastResponse) -> Void) {
		API.moviesProvider.request(.getCastDetails(id: movieId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let castDetail = try dataResponse.map(CastResponse.self)
					completionHandler(castDetail)

				} catch {
					self.showAlert(title: error.localizedDescription, message: "")
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription ?? "", message: "")
			}
		}
	}

	func getPersonCastDetails(movieId: Int, completionHandler: @escaping (CastResponse) -> Void) {
		API.moviesProvider.request(.getPersonCastCredits(id: movieId)) { [weak self] (result) in
			guard let self = self else { return }

			switch result {

			case .success(let dataResponse):
				do {
					let castDetail = try dataResponse.map(CastResponse.self)
					completionHandler(castDetail)

				} catch {
					self.showAlert(title: error.localizedDescription, message: "")
				}
			case .failure(let error):
				self.showAlert(title: error.errorDescription ?? "", message: "")
			}
		}
	}
	
}
