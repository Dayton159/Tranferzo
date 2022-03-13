//
//  OSTextField.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import UIKit

@IBDesignable
class OSTextField: UIView {
  // MARK: - Properties
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var errorMessage: UILabel!
  @IBOutlet weak var lineView: UIView!
  @IBOutlet weak var button: UIButton!
  
  var textFieldDidChange: ((String) -> Void)?
  var buttonSelected: (() -> Void)?
  private var hideSecureText = true
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
  
  func showAlertMessage(_ message: String) {
    if !message.isEmpty {
      self.showView(errorMessage, hidden: false)
      self.errorMessage.text = message
      self.lineView.backgroundColor = Constants.Color.error
    } else {
      self.lineView.backgroundColor = Constants.Color.underline
      self.showView(errorMessage, hidden: true)
    }
  }
  
  func showPasswordToogle() {
    self.hideSecureText.toggle()
    self.isSecureText = self.hideSecureText
    self.buttonImage = self.textField.isSecureTextEntry ? Constants.Image.eyeSlash : Constants.Image.eye
  }
  
  private func showView(_ view: UIView, hidden: Bool) {
    UIView.transition(with: view, duration: 0.2, options: .transitionCrossDissolve, animations: nil)
    view.isHidden = hidden
  }
}

// MARK: - Extensions
extension OSTextField {
  func xibSetup() {
    contentView = loadNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(contentView)
    
    self.textField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .allEditingEvents)
    self.button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
  }
  
  @objc func didChangeTextField(_ sender: UITextField) {
    let value = textField.text ?? ""
    self.textFieldDidChange?(value)
  }
  
  @objc func didTapButton(_ sender: UIButton) {
    self.buttonSelected?()
  }
}

extension OSTextField {
  
  @IBInspectable var showButton: Bool {
    get { return !self.button.isHidden }
    set { self.button.isHidden = !newValue }
  }
  
  @IBInspectable var buttonImage: UIImage? {
    get { return self.button.image(for: .normal) }
    set { self.button.setImage(newValue, for: .normal)}
  }
  
  @IBInspectable var title: String? {
    get { return self.titleLabel.text }
    set { self.titleLabel.text = newValue }
  }
  
  @IBInspectable var placeholder: String? {
    get { return textField.placeholder }
    set { self.textField.attributedPlaceholder = NSAttributedString(
      string: newValue ?? "",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText])
    }
  }
  
  @IBInspectable var isSecureText: Bool {
    get { return self.textField.isSecureTextEntry}
    set { self.textField.isSecureTextEntry = newValue }
  }
  
  @IBInspectable var allowEditing: Bool {
    get { return self.textField.isEnabled }
    set { self.textField.isEnabled = newValue }
  }
}
