//
//  PersonDetailViewController+CollectionView.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

extension PersonDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return castsModel.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = layoutableView.castCollectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as? CastCell else {return UICollectionViewCell()}
		cell.configure(model: castsModel[indexPath.row])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: layoutableView.castCollectionView.frame.size.height, height: layoutableView.castCollectionView.frame.size.height)
	}
}
