//
//  PersonDetails.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

struct PersonDetails {

  let biography: String
  let birthday: String
  let placeOfBirth: String
  let profilePath: String?

  var posterURL: URL? {
    guard let path = profilePath else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
  }
}

extension PersonDetails: Codable {
  enum CodingKeys: String, CodingKey {
    case biography
    case birthday
    case placeOfBirth
    case profilePath
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    biography = try container.decode(String.self, forKey: .biography)
    birthday = try container.decode(String.self, forKey: .birthday)
    placeOfBirth = try container.decode(String.self, forKey: .placeOfBirth)
    profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)

  }
}
