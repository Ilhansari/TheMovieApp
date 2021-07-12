//
//  MovieFeedLoader.swift
//  TheMovieFeed
//
//  Created by Ilhan Sari on 12.07.2021.
//

import Foundation

enum LoadFeedResult {
    case succees([MovieFeedItem])
    case error
}

protocol MovieFeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
