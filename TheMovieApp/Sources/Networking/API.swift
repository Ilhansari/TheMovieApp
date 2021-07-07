//
//  API.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Moya
import UIKit

final class API {
	private static var plugins: [PluginType] {
		#if DEBUG
		return [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
		#else
		return []
		#endif
	}

	static let moviesProvider = MoyaProvider<MoviesService>(plugins: plugins)
}
