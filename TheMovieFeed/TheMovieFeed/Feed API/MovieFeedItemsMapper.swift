//
//  MovieFeedItemsMapper.swift
//  TheMovieFeed
//
//  Created by Ilhan Sari on 2.11.2021.
//

import Foundation

class MovieFeedItemsMapper {

    private struct Root: Decodable {
        let results: [Item]
    }

    private struct Item: Decodable {
        let poster_path: String?
        let overview: String
        let id: Int
        let original_title: String
        let backdrop_path: String?

        var movieFeedItem: MovieFeedItem {
            return MovieFeedItem(posterPath: poster_path,
                                 overview: overview,
                                 id: id,
                                 originalTitle: original_title,
                                 backdropPath: backdrop_path)
        }
    }

    static var OK_200: Int { return 200 }

    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [MovieFeedItem] {
        guard response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.results.map { $0.movieFeedItem }
    }
}
