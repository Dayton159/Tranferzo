//
//  SectionHeaderView.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import UIKit

class SectionHeaderView: UIView {
  // MARK: - Properties
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var headerView:UIView! {
    didSet {
      headerView.roundCorners([.topRight, .topLeft], radius: 15)
    }
  }
  @IBOutlet weak var title: UILabel!
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
  
  func configureView(with title: String?) {
    self.title.text = title
  }
}

// MARK: - Extensions
extension SectionHeaderView {
  func xibSetup() {
    contentView = loadNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(contentView)
  }
}
