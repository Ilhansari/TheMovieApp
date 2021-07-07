//
//  UIViewController+Alert.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 21.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit

extension UIViewController {
	func showAlert(title: String?, message: String? = nil) {
      DispatchQueue.main.async { [weak self] in
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         self?.present(alert, animated: true, completion: nil)
      }
	}
}
