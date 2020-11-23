//
//  MovieResultsModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 20.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

struct MoviePerson {
	let knownForDepartment: String?
	let id: Int?
	let profilePath: String?
	let name: String?
	let posterPath: String?
	let title: String?
	let voteAverage: Double?
	let overview: String?
	let releaseDate: String?
	
	var posterURL: URL? {
		guard let path = posterPath else { return nil }
		return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
	}

	var profileURL: URL? {
		guard let path = profilePath else { return nil }
		return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
	}
}

extension MoviePerson: Codable {
	enum CodingKeys: String, CodingKey {
		case knownForDepartment
		case id
		case profilePath
		case name
		case posterPath
		case title
		case voteAverage
		case overview
		case releaseDate
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		knownForDepartment = try container.decodeIfPresent(String.self, forKey: .knownForDepartment)
		id = try container.decodeIfPresent(Int.self, forKey: .id)
		profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
		name = try container.decodeIfPresent(String.self, forKey: .name)
		posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
		title = try container.decodeIfPresent(String.self, forKey: .title)
		voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
		overview = try container.decodeIfPresent(String.self, forKey: .overview)
		releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)

	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(knownForDepartment, forKey: .knownForDepartment)
		try container.encodeIfPresent(id, forKey: .id)
		try container.encodeIfPresent(profilePath, forKey: .profilePath)
		try container.encodeIfPresent(name, forKey: .name)
		try container.encodeIfPresent(posterPath, forKey: .posterPath)
		try container.encodeIfPresent(title, forKey: .title)
		try container.encodeIfPresent(voteAverage, forKey: .voteAverage)
		try container.encodeIfPresent(overview, forKey: .overview)
		try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
	}
}

/// state search movie/person
public enum State {
	case ready
	case loading
	case empty
}
