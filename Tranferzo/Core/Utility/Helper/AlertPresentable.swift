//
//  AlertPresentable.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

import UIKit

protocol AlertDelegate: AnyObject {
  func didTapOkButton()
}

protocol AlertPopUpPresentable where Self: UIViewController { }

extension AlertPopUpPresentable {
  func showError(title: String = "Error", errorMessage: String, delegate: AlertDelegate? = nil) {
    let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)

    let action = UIAlertAction(title: "OK", style: .cancel) { _ in
      delegate?.didTapOkButton()
    }

    alert.addAction(action)
    showDetailViewController(alert, sender: self)
  }
}

