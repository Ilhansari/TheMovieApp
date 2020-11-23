//
//  PersonDetails.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

struct PersonDetailsModel {

	let biography: String?
	let birthday: String?
	let placeOfBirth: String?
	let profilePath: String?

	var posterURL: URL {
		return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")!
	}
}

extension PersonDetailsModel: Codable {
	enum CodingKeys: String, CodingKey {
		case biography
		case birthday
		case placeOfBirth = "place_of_birth"
		case profilePath = "profile_path"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		biography = try container.decodeIfPresent(String.self, forKey: .biography)
		birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
		placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth)
		profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)

	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(biography, forKey: .biography)
		try container.encodeIfPresent(birthday, forKey: .birthday)
		try container.encodeIfPresent(placeOfBirth, forKey: .placeOfBirth)
		try container.encodeIfPresent(profilePath, forKey: .profilePath)
	}
}
