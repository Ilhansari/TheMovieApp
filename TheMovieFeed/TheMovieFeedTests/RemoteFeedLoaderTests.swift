//
//  RemoteFeedLoaderTests.swift
//  TheMovieFeedTests
//
//  Created by Ilhan Sari on 28.07.2021.
//

import XCTest
import TheMovieFeed

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestFromURL() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_load_requestTwiceDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.connectivity)) {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        }
    }

    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: .failure(.invalidData)) {
                let json = makeItemJSON([])
                client.complete(withStatusCode: code, data: json, at: index)
            }
        }
    }

    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.invalidData)) {
            let invalidJSON = Data("invalid.json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        }
    }

    func test_load_deliversErrorOn200HTTPResponseWithEmptyJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .success([])) {
            let emptyListJSON = makeItemJSON([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        }
    }

    func test_load_deliversErrorOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let item1 = makeItem(posterPath: "From about NewYork",
                             overview: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
                             id: 112312,
                             originalTitle: "Superman",
                             backdropPath: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg")

        let item2 = makeItem(overview: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
                             id: 112313,
                             originalTitle: "Superman")

        let items = [item1.model, item2.model]

        expect(sut, toCompleteWith: .success(items)) {
            let data = makeItemJSON([item1.json, item2.json])
            client.complete(withStatusCode: 200, data: data)
        }
    }

    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader,
                                                                           client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }

    private func makeItem(posterPath: String? = nil,
                          overview: String, id: Int,
                          originalTitle: String,
                          backdropPath: String? = nil) -> (model: MovieFeedItem,
                                                           json: [String: Any]) {

        let item = MovieFeedItem(posterPath: posterPath,
                                 overview: overview,
                                 id: id,
                                 originalTitle: originalTitle,
                                 backdropPath: backdropPath)

        let json: [String: Any] = [
            "poster_path": posterPath,
            "overview": overview,
            "id": id,
            "original_title": originalTitle,
            "backdrop_path": backdropPath
        ]

        return (item, json)
    }

    private func makeItemJSON(_ items: [[String: Any]]) -> Data {
        let json = ["results": items]
        return try! JSONSerialization.data(withJSONObject: json)

    }

    private func expect(_ sut: RemoteFeedLoader,
                        toCompleteWith result: RemoteFeedLoader.Result,
                        when action: () -> Void,
                        file: StaticString = #file,
                        line: UInt = #line) {

        var capturedResults = [RemoteFeedLoader.Result]()
        sut.load { capturedResults.append($0) }

        action()

        XCTAssertEqual(capturedResults, [result], file: file, line: line)
    }

    private class HTTPClientSpy: HTTPClient {

        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()

        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }

        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url: url, completion: completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }

        func complete(withStatusCode code: Int,
                      data: Data,
                      at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index], statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil)!

            messages[index].completion(.success(data, response))
        }
    }
}
