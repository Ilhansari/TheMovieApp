//
//  MovieModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 20.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

struct MoviePersonResponse {
	let page: Int?
	let totalResults: Int?
	let totalPages: Int?
	var results: [MoviePersonModel] = []
}

extension MoviePersonResponse: Codable {
	enum CodingKeys: String, CodingKey {
		case page
		case totalResults = "total_results"
		case totalPages = "total_pages"
		case results
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		page = try container.decodeIfPresent(Int.self, forKey: .page)
		totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
		totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
		results = try container.decodeIfPresent([MoviePersonModel].self, forKey: .results) ?? []
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(page, forKey: .page)
		try container.encodeIfPresent(totalResults, forKey: .totalResults)
		try container.encodeIfPresent(totalPages, forKey: .totalPages)
		try container.encodeIfPresent(results, forKey: .results)

	}

}

