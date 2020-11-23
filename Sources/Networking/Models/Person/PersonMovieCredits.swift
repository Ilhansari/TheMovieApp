//
//  PersonCastCreditModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

struct PersonMovieCredits {
	let originalTitle: String?
	let profilePath: String?

	var profileURL: URL? {
		guard let path = profilePath else { return nil }
		return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
	}
}

extension PersonMovieCredits: Codable {
	enum CodingKeys: String, CodingKey {
		case originalTitle
		case profilePath
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
		profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)

	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(originalTitle, forKey: .originalTitle)
		try container.encodeIfPresent(profilePath, forKey: .profilePath)
	}
}
