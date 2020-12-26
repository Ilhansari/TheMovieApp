//
//  CastDetailModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

struct CastDetail {

  let name: String?
  let originalTitle: String?
  let profilePath: String?
  let posterPath: String?
  let character: String?

  var profileURL: URL? {
    guard let path = profilePath else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
  }

  var posterURL: URL? {
    guard let path = posterPath else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
  }
}

extension CastDetail: Codable {
  enum CodingKeys: String, CodingKey {
    case name
    case originalTitle
    case profilePath
    case posterPath
    case character
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    name = try container.decodeIfPresent(String.self, forKey: .name)
    originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
    profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
    posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    character = try container.decodeIfPresent(String.self, forKey: .character)
  }
}
