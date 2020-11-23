//
//  MovieDetailModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

struct MovieDetail: Codable {
	let adult: Bool?
	let id: Int?
	let originalTitle: String?
	let overview: String?
	let posterPath: String?
	let releaseDate: String?
	let title: String?
	let video: Bool?
	let voteAverage: Double?

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

		adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
		id = try container.decodeIfPresent(Int.self, forKey: .id)
		originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
		overview = try container.decodeIfPresent(String.self, forKey: .overview)
		posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
		releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
		title = try container.decodeIfPresent(String.self, forKey: .title)
		video = try container.decodeIfPresent(Bool.self, forKey: .video)
		voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)

	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(adult, forKey: .adult)
		try container.encodeIfPresent(id, forKey: .id)
		try container.encodeIfPresent(originalTitle, forKey: .originalTitle)
		try container.encodeIfPresent(overview, forKey: .overview)
		try container.encodeIfPresent(posterPath, forKey: .posterPath)
		try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
		try container.encodeIfPresent(title, forKey: .title)
		try container.encodeIfPresent(video, forKey: .video)
		try container.encodeIfPresent(voteAverage, forKey: .voteAverage)
	}
}
