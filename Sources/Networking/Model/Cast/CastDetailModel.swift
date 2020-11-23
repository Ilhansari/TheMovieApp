//
//  CastDetailModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

struct CastDetailModel {

	let name: String?
	let originalTitle: String?
	let profilPath: String?
	let posterPath: String?
	let character: String?

	var profileURL: URL {
		return URL(string: "https://image.tmdb.org/t/p/w500\(profilPath ?? "")")!
	}

	var posterURL: URL {
		return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
	}
}

extension CastDetailModel: Codable {
	enum CodingKeys: String, CodingKey {
		case name
		case originalTitle = "original_title"
		case profilPath = "profile_path"
		case posterPath = "poster_path"
		case character
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		name = try container.decodeIfPresent(String.self, forKey: .name)
		originalTitle = try container.decodeIfPresent(String.self, forKey: .name)
		profilPath = try container.decodeIfPresent(String.self, forKey: .profilPath)
		posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
		character = try container.decodeIfPresent(String.self, forKey: .character)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(name, forKey: .name)
		try container.encodeIfPresent(profilPath, forKey: .profilPath)
		try container.encodeIfPresent(posterPath, forKey: .posterPath)
		try container.encodeIfPresent(character, forKey: .character)
	}
}
