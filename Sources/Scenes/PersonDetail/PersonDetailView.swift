//
//  PersonDetailView.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class PersonDetailView: UIView {

	//MARK: User Interface
	lazy var scrollView: UIScrollView = {
		let view = UIScrollView()
		return view
	}()

	lazy var contentView: UIView = {
		let view = UIView()
		return view
	}()

	private lazy var profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleToFill
		imageView.layer.cornerRadius = 6
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .gray)
		view.isHidden = true
		return view
	}()

	private lazy var birthdayTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.text = "Birtday"
		label.font = .boldSystemFont(ofSize: 18)
		return label
	}()

	private lazy var birthdayLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		return label
	}()

	private lazy var placeOfBirthTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.text = "Place Of Birth"
		label.font = .boldSystemFont(ofSize: 18)
		return label
	}()

	private lazy var placeOfBirthLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.adjustsFontSizeToFitWidth = true
		return label
	}()

	private lazy var biographyTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.text = "Biography"
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	private lazy var castTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.text = "Casts"
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	lazy var castCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		layout.scrollDirection = .horizontal
		collectionView.backgroundColor = .lightGray
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.register(CastCell.self, forCellWithReuseIdentifier: "CastCell")
		return collectionView
	}()

	private lazy var biographyLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.numberOfLines = 0
		label.font = .init(descriptor: .init(), size: 13)
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

//MARK: Activity Indicator Hide/Show
extension PersonDetailView {
	func showActivityIndicator() {
		activityIndicator.startAnimating()
		activityIndicator.isHidden = false
	}

	func hideActivityIndicator() {
		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
	}
}

//MARK: Configure View
extension PersonDetailView {
	func configureView(_ model: PersonDetailsModel) {
		profileImageView.kf.setImage(with: model.posterURL)
		biographyLabel.text = model.biography
		birthdayLabel.text = model.birthday
		placeOfBirthLabel.text = model.placeOfBirth
	}
}

//MARK: Initialize UI and Constraints
extension PersonDetailView {
	private func setupViews() {
		backgroundColor = .white

		addSubview(scrollView)
		scrollView.addSubview(contentView)

		contentView.addSubview(profileImageView)
		contentView.addSubview(birthdayTitleLabel)
		contentView.addSubview(birthdayLabel)
		contentView.addSubview(placeOfBirthTitleLabel)
		contentView.addSubview(placeOfBirthLabel)
		contentView.addSubview(castTitleLabel)
		contentView.addSubview(castCollectionView)
		contentView.addSubview(biographyTitleLabel)
		contentView.addSubview(biographyLabel)
		contentView.addSubview(activityIndicator)
	}

	private func setupLayout() {

		scrollView.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview()
		}

		contentView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
			make.width.height.equalToSuperview()
			make.height.equalToSuperview().priority(250)
		}

		profileImageView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(12)
			make.leading.equalToSuperview().inset(12)
			make.height.equalTo(200)
			make.width.equalTo(120)
		}

		placeOfBirthTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(profileImageView)
			make.leading.equalTo(profileImageView.snp.trailing).offset(12)
			make.trailing.equalToSuperview()
		}

		placeOfBirthLabel.snp.makeConstraints { make in
			make.top.equalTo(placeOfBirthTitleLabel.snp.bottom).offset(8)
			make.leading.equalTo(profileImageView.snp.trailing).offset(12)
			make.trailing.equalToSuperview().inset(6)
		}

		birthdayTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(placeOfBirthLabel.snp.bottom).offset(12)
			make.leading.equalTo(profileImageView.snp.trailing).offset(12)
			make.trailing.equalToSuperview()
		}

		birthdayLabel.snp.makeConstraints { make in
			make.top.equalTo(birthdayTitleLabel.snp.bottom).offset(8)
			make.leading.equalTo(profileImageView.snp.trailing).offset(12)
			make.trailing.equalToSuperview()
		}

		castTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(birthdayLabel.snp.bottom).offset(8)
			make.leading.equalTo(profileImageView.snp.trailing).offset(12)
			make.trailing.equalToSuperview()
		}

		castCollectionView.snp.makeConstraints { make in
			make.top.equalTo(castTitleLabel.snp.bottom).offset(8)
			make.leading.equalTo(profileImageView.snp.trailing).offset(12)
			make.trailing.equalToSuperview()
			make.height.equalTo(80)
		}

		biographyTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(profileImageView.snp.bottom).offset(24)
			make.leading.trailing.equalToSuperview().inset(6)
		}

		biographyLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(6)
			make.top.equalTo(biographyTitleLabel.snp.bottom).offset(8)
		}

		activityIndicator.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.height.equalTo(50)
		}

	}
}
