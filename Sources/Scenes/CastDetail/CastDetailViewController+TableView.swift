//
//  CastDetailViewController+TableView.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 23.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit


//MARK: UITableViewDataSource, UITableViewDelegate
extension CastDetailViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return castDetailModel.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as! CommonCell
		cell.configure(model: castDetailModel[indexPath.row])
		return cell
	}
}
