//
//  MovieDetailModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

struct MovieDetail: Codable {
  let adult: Bool
  let id: Int
  let originalTitle: String
  let overview: String
  let posterPath: String?
  let releaseDate: String
  let title: String
  let video: Bool
  let voteAverage: Double

  var posterURL: URL? {
    guard let path = posterPath else {return nil}
    return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
  }
}

extension MovieDetail {
  enum CodingKeys: String, CodingKey {
    case adult
    case id
    case originalTitle
    case overview
    case posterPath
    case releaseDate
    case title
    case video
    case voteAverage
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    adult = try container.decode(Bool.self, forKey: .adult)
    id = try container.decode(Int.self, forKey: .id)
    originalTitle = try container.decode(String.self, forKey: .originalTitle)
    overview = try container.decode(String.self, forKey: .overview)
    posterPath = try container.decode(String.self, forKey: .posterPath)
    releaseDate = try container.decode(String.self, forKey: .releaseDate)
    title = try container.decode(String.self, forKey: .title)
    video = try container.decode(Bool.self, forKey: .video)
    voteAverage = try container.decode(Double.self, forKey: .voteAverage)

  }
}
