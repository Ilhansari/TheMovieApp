//
//  MovieDetailView.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieDetailView: UIView {

	// MARK: User Interface
	private lazy var coverImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleToFill
		return imageView
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont.boldSystemFont(ofSize: 24)
		label.textAlignment = .center
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.5
		return label
	}()

	lazy var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .gray)
		view.isHidden = true
		return view
	}()

	lazy var trailerButton: UIButton = {
		let button = UIButton()
		button.setTitle("Watch Trailer", for: .normal)
		button.backgroundColor = .gray
		button.layer.cornerRadius = 9
		button.layer.masksToBounds = true
		return button
	}()

	private lazy var summaryLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.text = "Summary"
		label.font = .boldSystemFont(ofSize: 18)
		return label
	}()

	private lazy var summarySubLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.numberOfLines = 9
		label.adjustsFontSizeToFitWidth = true
		return label
	}()

	lazy var castDetailButton: UIButton = {
		let button = UIButton()
		button.setTitle("Cast Details", for: .normal)
		button.backgroundColor = .gray
		button.layer.cornerRadius = 9
		button.layer.masksToBounds = true
		return button
	}()

	lazy var ratingLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
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

// MARK: Initialize UI and Constraints
extension MovieDetailView {
	private func setupViews() {
		backgroundColor = .white

		addSubview(coverImageView)
		addSubview(titleLabel)
		addSubview(ratingLabel)
		addSubview(trailerButton)
		addSubview(summaryLabel)
		addSubview(summarySubLabel)
		addSubview(castDetailButton)
		addSubview(activityIndicator)
	}

	private func setupLayout() {

		coverImageView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.height.equalToSuperview().multipliedBy(0.4)
			make.top.equalToSuperview()
		}

		titleLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(6)
			make.top.equalTo(coverImageView.snp.bottom).offset(8)
		}

		ratingLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
		}

		trailerButton.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(24)
			make.top.equalTo(ratingLabel.snp.bottom).offset(8)
		}

		summaryLabel.snp.makeConstraints { make in
			make.top.equalTo(trailerButton.snp.bottom).offset(16)
			make.leading.trailing.equalToSuperview().inset(24)
		}

		summarySubLabel.snp.makeConstraints { make in
			make.top.equalTo(summaryLabel.snp.bottom).offset(8)
			make.leading.trailing.equalToSuperview().inset(24)
		}

		castDetailButton.snp.makeConstraints { make in
			make.width.equalToSuperview().multipliedBy(0.5)
			make.centerX.equalToSuperview()
			make.top.equalTo(summarySubLabel.snp.bottom).offset(16)
		}

		activityIndicator.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.height.equalTo(50)
		}
	}
}

// MARK: Activity Indicator Hide/Show
extension MovieDetailView {
	func showActivityIndicator() {
		activityIndicator.startAnimating()
		activityIndicator.isHidden = false
	}
	
	func hideActivityIndicator() {
		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
	}
}

// MARK: Configure View
extension MovieDetailView {
	func configureView(_ model: MovieDetail) {
		coverImageView.kf.setImage(with: model.posterURL)
		titleLabel.text = model.title
		ratingLabel.text = model.voteAverage?.ratingText
		summarySubLabel.text = model.overview
	}
}
