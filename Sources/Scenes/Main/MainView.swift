//
//  MainView.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 20.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import SnapKit

final class MainView: UIView {

	// MARK: User Interface
	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.backgroundColor = .white
		return tableView
	}()

	private lazy var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .gray)
		view.isHidden = true
		return view
	}()

	lazy var segmentedControl: UISegmentedControl = {
		let items = ["Movie", "Person"]
		let view = UISegmentedControl(items: items)
		view.selectedSegmentIndex = 0
		view.backgroundColor = .white
		return view
	}()

	private lazy var emptyView: UIView = {
		let view = UIView()
		view.isHidden = true
		return view
	}()

	private lazy var emptyImageView: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysTemplate))
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private lazy var emptyLabel: UILabel = {
		let label = UILabel()
		label.text = "No movies found with selected search"
		label.font = UIFont.boldSystemFont(ofSize: 18)
		label.lineBreakMode = .byWordWrapping
		label.textAlignment = .center
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
extension MainView {
	private func setupViews() {
		backgroundColor = .white

		addSubview(tableView)
		addSubview(segmentedControl)
		addSubview(activityIndicator)
		addSubview(emptyView)

		emptyView.addSubview(emptyImageView)
		emptyView.addSubview(emptyLabel)
	}

	private func setupLayout() {
		tableView.snp.makeConstraints { make in
			make.leading.trailing.top.equalToSuperview()
			make.bottom.equalTo(segmentedControl.snp.top)
		}

		segmentedControl.snp.makeConstraints { make in
			make.width.equalToSuperview().multipliedBy(0.7)
			make.height.equalTo(40)
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview().inset(20)
		}

		activityIndicator.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.height.equalTo(50)
		}

		emptyView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.equalToSuperview()
			make.height.equalToSuperview().multipliedBy(0.4)
		}

		emptyImageView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.height.equalTo(40)
		}

		emptyLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(emptyImageView.snp.bottom).offset(12)
		}
	}
}

// MARK: Activity Indicator and Empty View Hide/Show
extension MainView {
	func showActivityIndicator() {
		activityIndicator.startAnimating()
		activityIndicator.isHidden = false
	}
	
	func hideActivityIndicator() {
		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
	}

	func showEmptyView(isHidden: Bool = true) {
		emptyView.isHidden = isHidden
		tableView.isHidden = !isHidden
	}

}
