//
//  SectionFooterView.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import UIKit

class SectionFooterView: UIView {
  // MARK: - Properties
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var footerView:UIView! {
    didSet {
      footerView.roundCorners([.bottomRight, .bottomLeft], radius: 15)
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
}

// MARK: - Extensions
extension SectionFooterView {
  func xibSetup() {
    contentView = loadNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(contentView)
  }
}
