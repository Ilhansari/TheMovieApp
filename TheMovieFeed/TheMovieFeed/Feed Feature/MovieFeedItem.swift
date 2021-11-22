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
