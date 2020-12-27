//
//  MovieDetailViewModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 26.12.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieDetailViewModel {

  private var networkManager: NetworkManager
  private var _videoKey = BehaviorRelay<String?>(value: nil)
  private var _movieDetail = BehaviorRelay<MovieDetail?>(value: nil)
  private let _isFetching = BehaviorRelay<Bool>(value: false)

  init(networkManager: NetworkManager, id: Int) {
    self.networkManager = networkManager
    fetchMovieDetail(id: id)
    fetchMovieVideos(id: id)
  }

  var isFetching: Driver<Bool> {
    return _isFetching.asDriver()
  }

  var movieDetail: Driver<MovieDetail?> {
    return _movieDetail.asDriver()
  }

  var videoKey: Driver<String?> {
    return _videoKey.asDriver()
  }

  private func fetchMovieDetail(id: Int) {
    _isFetching.accept(true)
    networkManager.getMovieDetails(movieId: id) { [weak self] response in
      self?._isFetching.accept(false)
      self?._movieDetail.accept(response)
    }
  }

  private func fetchMovieVideos(id: Int) {
    _isFetching.accept(true)
    networkManager.getMovieVideos(movieId: id) { [weak self] response in
      self?._isFetching.accept(false)
      for videoKey in response.results {
        self?._videoKey.accept(videoKey.key)
      }
    }
  }

  func loadYoutube(videoKey: String?) {
    guard let videoKey = videoKey else { return }
    
    guard  let appURL = URL(string: "youtube://www.youtube.com/watch?v=\(videoKey)"),
      let webURL = URL(string: "https://www.youtube.com/watch?v=\(videoKey)")
      else { return }

    let application = UIApplication.shared

    if application.canOpenURL(appURL) {
      application.open(appURL)
    } else {
      application.open(webURL)
    }
  }

}
