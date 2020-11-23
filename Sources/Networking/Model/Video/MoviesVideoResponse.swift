//
//  MoviesVideoResponse.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

struct MoviesVideoResponse {
	var results: [MoviesVideoModel] = []
}

extension MoviesVideoResponse: Codable {
	enum CodingKeys: String, CodingKey {
		case results
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		results = try container.decodeIfPresent([MoviesVideoModel].self, forKey: .results) ?? []
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(results, forKey: .results)

	}

}
