//
//  LoginView.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import UIKit

class LoginView: BaseView, LoginViewProtocol, AlertPopUpPresentable {
  
  // MARK: - Properties
  @IBOutlet weak var usernameContainer: OSTextField!
  @IBOutlet weak var passwordContainer: OSTextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var dontHaveAccButton: UIButton! {
    didSet {
      let attributedTitle = NSMutableAttributedString(string: "Don't have an account?   ", attributes: [.font: Constants.Font.novaRegular(16), .foregroundColor: UIColor.black])
      
      attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font: Constants.Font.novaBold(16), .foregroundColor: UIColor.black]))
      
      dontHaveAccButton.setAttributedTitle(attributedTitle, for: .normal)
    }
  }
  
  var setUsernameData: ((String) -> Void)?
  var setPasswordData: ((String) -> Void)?
  var authenticateUser: (() -> Void)?
  var authSuccess: ((String) -> Void)?
  var signUpSelected: (() -> Void)?
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindView()
    self.navigationController?.navigationBar.isHidden = true
  }
  
  func showError(by message: String) {
    Delay.wait {
      self.showError(errorMessage: message)
    }
  }
  
  func state(_ state: NetworkState) {
    switch state {
    case .loading:
      self.showLoader()
    default:
      self.hideLoader()
    }
  }
  
  func authSuccess(status: String) {
    self.emptyField()
    self.authSuccess?(status)
  }
  
  func checkLoginStatus(isValid: Bool) {
    self.loginButton.isEnabled = isValid
    self.loginButton.isUserInteractionEnabled = isValid
    self.loginButton.backgroundColor = isValid ? Constants.Color.activeBtn : Constants.Color.disableBtn
  }
  
  func bindView() {
    self.usernameContainer.textFieldDidChange = { [weak self] name in
      guard let self = self else { return }
      self.usernameContainer.showAlertMessage(name.isEmpty ? "Username is required" : "")
      self.setUsernameData?(name)
    }
    
    self.passwordContainer.textFieldDidChange = { [weak self] password in
      guard let self = self else { return }
      self.passwordContainer.showAlertMessage(password.isEmpty ? "Password is required" : "")
      self.setPasswordData?(password)
    }
    
    self.passwordContainer.buttonSelected = { [weak self] in
      guard let self = self else { return }
      self.passwordContainer.showPasswordToogle()
    }
    
    self.loginButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
    self.dontHaveAccButton.addTarget(self, action: #selector(didTapNoAccount(_:)), for: .touchUpInside)
  }
  
  private func emptyField() {
    self.usernameContainer.textField.text = nil
    self.passwordContainer.textField.text = nil
    self.setUsernameData?("")
    self.setPasswordData?("")
  }
  
  // MARK: - Selector
  
  @objc func didTapLogin(_ sender: UIButton) {
    self.authenticateUser?()
  }
  
  @objc func didTapNoAccount(_ sender: UIButton) {
    self.signUpSelected?()
  }
}
