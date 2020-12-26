//
//  CastDetailViewModel.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 13.12.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

struct CastDetailViewModel {

  private var castDetails: CastDetail

  init(castDetails: CastDetail) {
    self.castDetails = castDetails
  }

  var posterURL: URL? {
    return castDetails.posterURL
  }

  var character: String? {
    return castDetails.character
  }

  var posterPath: String? {
     return castDetails.posterPath
   }

}
