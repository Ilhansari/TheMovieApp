//
//  RemoteFeedLoaderTests.swift
//  TheMovieFeedTests
//
//  Created by Ilhan Sari on 28.07.2021.
//

import XCTest

class RemoteFeedLoader {

    func load() {
        HTTPClient.shared.requestedURL = URL(string: "www.google.com")
    }
}

class HTTPClient {
    static let shared = HTTPClient()

    private init() { }

    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()

        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()

        sut.load()

        XCTAssertNotNil(client.requestedURL)
    }
}
