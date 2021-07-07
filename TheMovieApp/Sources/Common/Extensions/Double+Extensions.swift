//
//  Double+Extensions.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation

extension Double {
	var ratingText: String {
		let rating = Int(self)
		let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
			 return acc + "⭐️"
		 }
		return ratingText
	}
}
