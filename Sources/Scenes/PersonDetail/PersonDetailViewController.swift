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
	private var layoutableView: PersonDetailView {
		guard let personDetailView = view as? PersonDetailView else {
			fatalError("view property has not been initialized yet, or not initialized as PersonDetailView.")
		}
		return personDetailView
	}

	// MARK: Properties
	private var personId: Int
	private var networkManager: NetworkManager
	private var castsModel = [CastDetail]()

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

// MARK: Networking
extension PersonDetailViewController {
	private func fetchPersonDetail(personId: Int) {
		layoutableView.showActivityIndicator()
		networkManager.getPersonDetails(personId: personId) { [weak self] result in
			guard let self = self else { return }
			self.layoutableView.hideActivityIndicator()
			self.layoutableView.configureView(result)
		}
	}

	private func fetchPersonCasts() {
		layoutableView.showActivityIndicator()
		networkManager.getPersonCastDetails(movieId: personId) { [weak self] result in
			guard let self = self else { return }
			self.layoutableView.hideActivityIndicator()
			self.castsModel.append(contentsOf: result.cast)
			self.layoutableView.castCollectionView.reloadData()
		}
	}
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension PersonDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return castsModel.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = layoutableView.castCollectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as? CastCell else { fatalError("Unable to dequeue cell")}
		cell.configure(model: castsModel[indexPath.row])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: layoutableView.castCollectionView.frame.size.height, height: layoutableView.castCollectionView.frame.size.height)
	}
}
