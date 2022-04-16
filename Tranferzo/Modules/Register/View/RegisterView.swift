//
//  RegisterView.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import UIKit

class RegisterView: BaseView, RegisterViewProtocol, AlertPopUpPresentable {
  
  // MARK: - Properties
  @IBOutlet weak var usernameContainer: OSTextField!
  @IBOutlet weak var passwordContainer: OSTextField!
  @IBOutlet weak var confirmPasswordContainer: OSTextField!
  @IBOutlet weak var registerButton: UIButton!
  
  @IBOutlet weak var alreadyHaveAccButton: UIButton! {
    didSet {
      let attributedTitle = NSMutableAttributedString(string: "Already have an account?   ", attributes: [.font: Constants.Font.novaRegular(16), .foregroundColor: UIColor.black])
      
      attributedTitle.append(NSAttributedString(string: "Log in", attributes: [.font: Constants.Font.novaBold(16), .foregroundColor: UIColor.black]))
      
      alreadyHaveAccButton.setAttributedTitle(attributedTitle, for: .normal)
    }
  }
  
  var setUsernameData: ((String) -> Void)?
  var setPasswordData: ((String) -> Void)?
  var setConfirmPasswordData: ((String) -> Void)?
  
  var registerUser: (() -> Void)?
  var registerSuccess: ((String) -> Void)?
  
  var loginSelected: (() -> Void)?
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindView()
  }
  
  func registerSuccess(status: String) {
    self.emptyField()
    self.registerSuccess?(status)
  }
  
  func checkRegisterStatus(isValid: Bool) {
    self.registerButton.isEnabled = isValid
    self.registerButton.isUserInteractionEnabled = isValid
    self.registerButton.backgroundColor = isValid ? Constants.Color.activeBtn : Constants.Color.disableBtn
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
      
      if let confirmPassValue = self.confirmPasswordContainer.textField.text, !confirmPassValue.isEmpty  {
        self.confirmPasswordContainer.showAlertMessage(confirmPassValue != password ? "Confirm password not match" : "")
      }
    }
    
    self.confirmPasswordContainer.textFieldDidChange = { [weak self] confirmPassword in
      guard let self = self else { return }
      self.confirmPasswordContainer.showAlertMessage(confirmPassword != self.passwordContainer.textField.text ? "Confirm password not match" : "")
      self.setConfirmPasswordData?(confirmPassword)
    }
    
    self.passwordContainer.buttonSelected = { [weak self] in
      guard let self = self else { return }
      self.passwordContainer.showPasswordToogle()
    }
    self.confirmPasswordContainer.buttonSelected = { [weak self] in
      guard let self = self else { return }
      self.confirmPasswordContainer.showPasswordToogle()
    }
    
    self.registerButton.addTarget(self, action: #selector(didTapRegister(_:)), for: .touchUpInside)
    self.alreadyHaveAccButton.addTarget(self, action: #selector(didTapHasAccount(_:)), for: .touchUpInside)
  }
  
  private func emptyField() {
    self.usernameContainer.textField.text = nil
    self.passwordContainer.textField.text = nil
    self.confirmPasswordContainer.textField.text = nil
    self.setUsernameData?("")
    self.setPasswordData?("")
    self.setConfirmPasswordData?("")
  }
  
  // MARK: - Selectors
  @objc func didTapHasAccount(_ sender: UIButton) {
    self.loginSelected?()
  }
  
  @objc func didTapRegister(_ sender: UIButton) {
    self.registerUser?()
  }
}
