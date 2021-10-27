//
//  PopularMovieItem.swift
//  TheMovieFeed
//
//  Created by Ilhan Sari on 12.07.2021.
//

import Foundation

public struct MovieFeedItem: Equatable {
    public let posterPath: String?
    public let overview: String
    public let id: Int
    public let originalTitle: String
    public let backdropPath: String?

    public init(posterPath: String?,
                overview: String,
                id: Int,
                originalTitle: String,
                backdropPath: String?) {
        self.posterPath = posterPath
        self.overview = overview
        self.id = id
        self.originalTitle = originalTitle
        self.backdropPath = backdropPath
    }
}

extension MovieFeedItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        case id
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
    }
}
