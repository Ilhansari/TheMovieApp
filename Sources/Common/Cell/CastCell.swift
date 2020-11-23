//
//  CastCell.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class CastCell: UICollectionViewCell {

	// MARK: User Interface
	private lazy var posterImageView: UIImageView = {
		let imageView = UIImageView()
		return imageView
	}()

	private lazy var titleView: UIView = {
		let view = UIView()
		view.backgroundColor = .black
		return view
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.textAlignment = .center
		label.adjustsFontSizeToFitWidth = true
		label.numberOfLines = 2
		return label
	}()

	lazy var noImageLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.textAlignment = .center
		label.text = "No Image"
		label.font = .boldSystemFont(ofSize: 15)
		label.adjustsFontSizeToFitWidth = true
		label.numberOfLines = 2
		label.isHidden = false
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

// MARK: Configure Model
extension CastCell {
	func configure(model: CastDetailModel) {
		posterImageView.kf.setImage(with: model.posterURL)
		titleLabel.text = model.character
		noImageLabel.isHidden = model.posterPath != nil
	}
}

// MARK: Configure View
extension CastCell {
	private func setupViews() {

		addSubview(posterImageView)

		posterImageView.addSubview(noImageLabel)
		posterImageView.addSubview(titleView)
		titleView.addSubview(titleLabel)
	}

	private func setupLayout() {
		posterImageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		noImageLabel.snp.makeConstraints { make in
			make.leading.top.trailing.equalToSuperview()
			make.bottom.equalTo(titleView.snp.top)
		}

		titleView.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview()
			make.height.equalTo(20)
		}
		
		titleLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
