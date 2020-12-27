//
//  MovieModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 20.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

struct MoviePersonResponse {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  var results: [MoviePerson] = []
}

extension MoviePersonResponse: Codable {
  enum CodingKeys: String, CodingKey {
    case page
    case totalResults
    case totalPages
    case results
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    page = try container.decode(Int.self, forKey: .page)
    totalResults = try container.decode(Int.self, forKey: .totalResults)
    totalPages = try container.decode(Int.self, forKey: .totalPages)
    results = try container.decode([MoviePerson].self, forKey: .results)
  }

}
