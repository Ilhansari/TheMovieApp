//
//  PersonDetailViewController.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import SnapKit

final class PersonDetailViewController: UIViewController {

	// MARK: view as a `Layoutable`
	var layoutableView: PersonDetailView {
		guard let personDetailView = view as? PersonDetailView else {
			fatalError("view property has not been initialized yet, or not initialized as \(PersonDetailView.self).")
		}
		return personDetailView
	}

	// MARK: Properties
	var personId: Int
	var networkManager: NetworkManager
	var castsModel = [CastDetailModel]()

	override func loadView() {
		view = PersonDetailView()
	}

	init(personId: Int, networkManager: NetworkManager) {
		self.personId = personId
		self.networkManager = networkManager
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}

// MARK: Setup View
extension PersonDetailViewController {
	private func setupView() {
		fetchPersonDetail(personId: personId)
		fetchPersonCasts()
		
		layoutableView.castCollectionView.dataSource = self
		layoutableView.castCollectionView.delegate = self
	}
}
