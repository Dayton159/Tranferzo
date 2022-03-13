//
//  BaseView.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

import UIKit

class BaseView: UIViewController {
  
  lazy var barBtn: UIButton = {
    let button = UIButton()
    return button
  }()
  
  private let activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
      activityIndicator.hidesWhenStopped = true
      return activityIndicator
  }()

  private let activityIndicatorBackgroundView: UIView = {
      let backgroundView = UIView()
      backgroundView.backgroundColor = .white
      return backgroundView
  }()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.activityIndicatorBackgroundView.addSubview(self.activityIndicator)
      self.view.addSubview(self.activityIndicatorBackgroundView)
      self.activityIndicatorBackgroundView.isHidden = true
  }

  override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      self.activityIndicatorBackgroundView.frame = self.view.bounds
  }
  
  func showLoader() {
      self.view.bringSubviewToFront(activityIndicatorBackgroundView)
      self.activityIndicator.center = self.activityIndicatorBackgroundView.center
      self.activityIndicatorBackgroundView.isHidden = false
      self.activityIndicator.startAnimating()
  }

  func hideLoader() {
      self.view.sendSubviewToBack(activityIndicatorBackgroundView)
      self.activityIndicatorBackgroundView.isHidden = true
      self.activityIndicator.stopAnimating()
  }
  
  func configureNavBar(withTitle title: String? = nil, prefersLargeTitles: Bool = false) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    appearance.backgroundColor = .secondarySystemBackground

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance

    navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
    navigationItem.title = title

    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.isTranslucent = true

    navigationController?.navigationBar.overrideUserInterfaceStyle = .light
    self.navigationController?.navigationBar.barStyle = .default
  }
}

extension BaseView {
  func configureRightBarButtonItem(image: UIImage? = nil, title: String? = nil) {
    let button = barBtn
    let barItem = UIBarButtonItem(customView: button)
    self.setBarBtnImage(image)
    self.setBarBtnTitle(title)
    self.enableBarBtn()
    navigationItem.rightBarButtonItem = barItem
  }
  
  func enableBarBtn( enable: Bool = true) {
    self.barBtn.isUserInteractionEnabled = enable
    self.barBtn.isEnabled = enable
  }

  private func setBarBtnImage(_ image: UIImage?) {
    self.barBtn.setImage(image, for: .normal)
  }
  
  private func setBarBtnTitle(_ title: String?) {
    self.barBtn.setTitle(title, for: .normal)
    self.barBtn.setTitleColor(.black, for: .normal)
  }
}
