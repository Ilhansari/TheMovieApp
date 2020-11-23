//
//  PersonDetailViewController+Networking.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

extension PersonDetailViewController {
	func fetchPersonDetail(personId: Int) {
		layoutableView.showActivityIndicator()
		networkManager.getPersonDetails(personId: personId) { result in
			self.layoutableView.hideActivityIndicator()
			self.layoutableView.configureView(result)
		}
	}

	func fetchPersonCasts() {
		layoutableView.showActivityIndicator()
		networkManager.getPersonCastDetails(movieId: personId) { result in
			self.layoutableView.hideActivityIndicator()
			self.castsModel.append(contentsOf: result.cast)
			self.layoutableView.castCollectionView.reloadData()
		}
	}
}
