//
//  DashboardHeaderView.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import UIKit

@IBDesignable
class DashboardHeaderView: UIView {
  // MARK: - Properties
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var accNumberLabel: UILabel!
  @IBOutlet weak var accHolderLabel: UILabel!
  
  @IBOutlet weak var headerView: UIView! {
    didSet {
      headerView.roundCorners([.topRight, .bottomRight], radius: 40)
    }
  }
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
  
  func configureView(with data: BalanceModel, holder name: String) {
    self.balanceLabel.text = data.balance
    self.accNumberLabel.text = data.accNumber
    self.accHolderLabel.text = name
  }
}

// MARK: - Extensions
extension DashboardHeaderView {
  func xibSetup() {
    contentView = loadNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(contentView)
  }
}
