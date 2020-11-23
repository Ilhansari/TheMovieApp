//
//  CastResponse.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

import UIKit

struct CastResponse {
	var cast: [CastDetailModel] = []
}

extension CastResponse: Codable {
	enum CodingKeys: String, CodingKey {
		case cast
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		cast = try container.decodeIfPresent([CastDetailModel].self, forKey: .cast) ?? []
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(cast, forKey: .cast)

	}

}
