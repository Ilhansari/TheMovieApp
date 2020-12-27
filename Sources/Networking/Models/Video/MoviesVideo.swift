//
//  MovieVideoModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

struct MoviesVideo {
	let key: String?
}

extension MoviesVideo: Codable {
	enum CodingKeys: String, CodingKey {
		case id
		case key
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		key = try container.decodeIfPresent(String.self, forKey: .key)
		
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encodeIfPresent(key, forKey: .key)
	}
}
