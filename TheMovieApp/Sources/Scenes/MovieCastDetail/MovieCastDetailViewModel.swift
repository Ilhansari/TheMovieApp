//
//  MovieCastDetailViewModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 27.12.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieCastDetailViewModel {
  
  private let networkManager: NetworkManager
  private let _movieCastDetail = BehaviorRelay<[CastDetail]>(value: [])
  private let _isFetching = BehaviorRelay<Bool>(value: false)
  
  var isFetching: Driver<Bool> {
    return _isFetching.asDriver()
  }
  
  var movieCastDetail: Driver<[CastDetail]> {
    return _movieCastDetail.asDriver()
  }
  
  var numberOfMovieCastDetailCount: Int {
    return _movieCastDetail.value.count
  }
  
  init(networkManager: NetworkManager, id: Int) {
    self.networkManager = networkManager
    self.fetchCastDetails(id: id)
  }
  
  func fetchCastDetails(id: Int) {
    self._isFetching.accept(true)
    networkManager.getMovieCastDetails(movieId: id) { [weak self] response in
      guard let self = self else { return }
      self._isFetching.accept(false)
      self._movieCastDetail.accept(response.cast)
    }
  }

}
