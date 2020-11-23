//
//  API.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import Moya

final class API {
	static let moviesProvider = MoyaProvider<MoviesService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
}
