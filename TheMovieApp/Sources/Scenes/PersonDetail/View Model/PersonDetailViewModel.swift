//
//  PersonDetailViewModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 13.12.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class PersonDetailViewModel {

  private var personDetails = BehaviorRelay<PersonDetails?>(value: nil)
  private var networkManager: NetworkManager
  private var personId: Int
  private var _isFetching = BehaviorRelay<Bool>(value: false)

  init(networkManager: NetworkManager, personId: Int) {
    self.networkManager = networkManager
    self.personId = personId
    self.fetchPersonDetail(personId: personId)
  }

  var profileURL: URL? {
    return personDetails.value?.posterURL
  }

  var biographyLabel: String? {
    return personDetails.value?.biography
  }

  var birthdayLabel: String? {
    return personDetails.value?.birthday
  }

  var placeOfBirthLabel: String? {
    return personDetails.value?.placeOfBirth
  }

  var personDetail: Driver<PersonDetails?> {
    return personDetails.asDriver()
  }
  
  var isFetching: Driver<Bool> {
    return _isFetching.asDriver()
  }

  private func fetchPersonDetail(personId: Int) {
    self._isFetching.accept(true)
    networkManager.getPersonDetails(personId: personId) { [weak self] response in
      self?._isFetching.accept(false)
      self?.personDetails.accept(response)
    }
  }
}
