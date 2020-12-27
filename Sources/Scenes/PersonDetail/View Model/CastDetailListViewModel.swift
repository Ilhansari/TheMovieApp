//
//  CastDetailListViewModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 13.12.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CastDetailListViewModel {
  
  private let networkManager: NetworkManager
  private let _castDetail = BehaviorRelay<[CastDetail]>(value: [])
  private let _isFetching = BehaviorRelay<Bool>(value: false)

  init(networkManager: NetworkManager, personId: Int) {
    self.networkManager = networkManager
    fetcCastDetails(personId: personId)
  }

  var isFetching: Driver<Bool> {
    return _isFetching.asDriver()
  }

  var castDetail: Driver<[CastDetail]> {
    return _castDetail.asDriver()
  }

  var numberOfCastDetail: Int {
    return _castDetail.value.count
  }

  func viewModelForCastDetail(at index: Int) -> CastDetailViewModel? {
    guard index < numberOfCastDetail else { return nil }

    return CastDetailViewModel(castDetails: _castDetail.value[index])

  }

  func fetcCastDetails(personId: Int) {
    self._castDetail.accept([])
    self._isFetching.accept(true)

    networkManager.getPersonCastDetails(movieId: personId) { [weak self] result in
      self?._isFetching.accept(false)
      self?._castDetail.accept(result.cast)
    }
  }
}
