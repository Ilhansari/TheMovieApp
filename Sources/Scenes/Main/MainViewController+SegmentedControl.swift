//
//  MainView+SegmentedControl.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

extension MainViewController {
	 func setupSegmentedControl() {
		layoutableView.segmentedControl.addTarget(self, action: #selector(MainViewController.segmentedControlChanged(_:)), for: .valueChanged)
	}

	@objc  func segmentedControlChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			fetchPopularMovies(page: 1)
			self.isSectionMovie = true
			navigationItem.title = "Popular Movies"
		case 1:
			fetchPopularPerson()
			self.isSectionMovie = false
			navigationItem.title = "Popular Person"
		default:
			fetchPopularMovies(page: 1)
			self.isSectionMovie = true
			navigationItem.title = "Popular Movies"
		}
	}
}
