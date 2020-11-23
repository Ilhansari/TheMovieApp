//
//  CommonCell.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class CommonCell: UITableViewCell {

	//MARK: User Interface
	private lazy var posterImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	lazy var noImageLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.textAlignment = .center
		label.text = "No Image"
		label.font = .boldSystemFont(ofSize: 15)
		label.adjustsFontSizeToFitWidth = true
		label.numberOfLines = 2
		label.isHidden = false
		return label
	}()


	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		return label
	}()

	private lazy var subTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.numberOfLines = 3
		return label
	}()

	private lazy var subtitleTwoLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = .italicSystemFont(ofSize: 12)
		return label
	}()

	private lazy var stackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel, subtitleTwoLabel])
		stackView.distribution = .equalSpacing
		stackView.axis = .vertical
		stackView.spacing = 4
		return stackView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
		setupLayout()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

//MARK: Configure Model
extension CommonCell {
	func configure(model: MoviePersonModel, isSectionMovie: Bool) {
		if isSectionMovie {
			posterImageView.kf.setImage(with: model.posterURL)
			titleLabel.text = model.title
			subTitleLabel.text = model.overview
			subtitleTwoLabel.text = model.releaseDate
			noImageLabel.isHidden = model.posterPath != nil
		} else {
			posterImageView.kf.setImage(with: model.profileURL)
			titleLabel.text = model.name
			subTitleLabel.text = model.knownForDepartment
			subtitleTwoLabel.text = ""
			noImageLabel.isHidden = model.profilePath != nil
		}
	}

	func configure(model: CastDetailModel) {
		posterImageView.kf.setImage(with: model.profileURL)
		titleLabel.text = "Name: \(model.name ?? "")"
		subTitleLabel.text = "Character: \(model.character ?? "")"
		noImageLabel.isHidden = model.profilPath != nil
	}
}

//MARK: Configure View
extension CommonCell {
	private func setupViews() {

		addSubview(posterImageView)
		posterImageView.addSubview(noImageLabel)
		addSubview(titleLabel)
		addSubview(subTitleLabel)
		addSubview(subtitleTwoLabel)
		addSubview(stackView)

	}

	private func setupLayout() {

		posterImageView.snp.makeConstraints { make in
			make.height.width.equalTo(150)
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().inset(8)
		}

		noImageLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		stackView.snp.makeConstraints { make in
			make.leading.equalTo(posterImageView.snp.trailing)
			make.top.bottom.equalToSuperview().inset(6)
			make.trailing.equalToSuperview()
		}
	}
}
