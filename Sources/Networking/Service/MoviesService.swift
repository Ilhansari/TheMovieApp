//
//  MoviesService.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 20.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import Moya

enum MoviesService {

  static private let apiKey = "2edd3456ac2d3b9996e13ee8f0f43a45"

  case getMostPopularMovieList(page: Int)
  case getMostPopularMovieListDetail(id: Int)
  case getMostPopularPersonList
  case getMostPopularPersonListDetail(id: Int)
  case getSearchMovie(query: String)
  case getCastDetails(id: Int)
  case getPersonCastCredits(id: Int)
  case getMovieVideos(id: Int)
}

extension MoviesService: TargetType {
  var baseURL: URL {
    guard let url = URL(string: "https://api.themoviedb.org/3/") else {
      fatalError("baseURL could not be configured.")
    }

    return url
  }

  var path: String {
    switch self {
    case .getMostPopularMovieList:
      return "movie/popular"
    case .getMostPopularMovieListDetail(let movieId):
      return "movie/\(movieId)"
    case .getSearchMovie:
      return "search/multi"
    case .getMostPopularPersonList:
      return "person/popular"
    case .getMostPopularPersonListDetail(let personId):
      return "person/\(personId)"
    case .getCastDetails(let id):
      return "movie/\(id)/credits"
    case .getPersonCastCredits(let id):
      return "person/\(id)/credits"
    case .getMovieVideos(let id):
      return "movie/\(id)/videos"
    }
  }

  var method: Moya.Method {
    return .get
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {
    case let .getMostPopularMovieList(page):
      return .requestParameters(
        parameters: ["api_key": MoviesService.apiKey, "page": page], encoding: URLEncoding.default)
    case .getMostPopularMovieListDetail,
         .getMostPopularPersonList,
         .getMostPopularPersonListDetail,
         .getCastDetails,
         .getPersonCastCredits,
         .getMovieVideos:
      return .requestParameters(
        parameters: ["api_key": MoviesService.apiKey], encoding: URLEncoding.default)
    case .getSearchMovie(let query):
      return .requestParameters(parameters: ["api_key": MoviesService.apiKey, "query": query, "include_adult": false], encoding: URLEncoding.default)
    }
  }

  var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }

  var validationType: ValidationType {
    return .successCodes
  }

}
