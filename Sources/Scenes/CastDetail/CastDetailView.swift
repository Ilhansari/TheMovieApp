//
//  MainView.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 20.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import SnapKit

final class CastDetailView: UIView {

	// MARK: User Interface
	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.backgroundColor = .white
		return tableView
	}()

	 lazy var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .gray)
		view.isHidden = true
		return view
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
extension CastDetailView {
	private func setupViews() {
		addSubview(tableView)
		addSubview(activityIndicator)
	}

	private func setupLayout() {
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		activityIndicator.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.height.equalTo(50)
		}
	}
}

// MARK: Activity Indicator Hide/Show
extension CastDetailView {
	func showActivityIndicator() {
		activityIndicator.startAnimating()
		activityIndicator.isHidden = false
	}

	func hideActivityIndicator() {
		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
	}
}
