//
//  Extension+Alert.swift
//  ChallengeBegin
//
//  Created by ilhan on 28.10.2019.
//  Copyright © 2019 İlhan Sarı. All rights reserved.
//

import UIKit

extension UIViewController {
	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
			  rootVC.present(alert, animated: true, completion: nil)
		  } else {
			  print("Root view controller is not set.")
		  }
	}
}
