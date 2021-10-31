//
//  RemoteFeedLoader.swift
//  TheMovieFeed
//
//  Created by Ilhan Sari on 27.09.2021.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public class RemoteFeedLoader {

    private let url: URL
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public enum Result: Equatable {
        case success([MovieFeedItem])
        case failure(Error)
    }

    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                do {
                    let items = try MovieFeedItemsMapper.map(data, response)
                    completion(.success(items))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

private class MovieFeedItemsMapper {

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

    static var OK_200: Int {
        return 200
    }

    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [MovieFeedItem] {
        guard response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.results.map({ $0.movieFeedItem })
    }
}
