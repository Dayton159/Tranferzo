//
//  UIView+Extension.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import UIKit

extension UIView {
  func loadNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: self.classForCoder), bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Can't load Nib") }
    return view
  }

  @IBInspectable var cornerRadius: CGFloat {
    get { return layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
  
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
      if #available(iOS 11.0, *) {
          clipsToBounds = true
          layer.cornerRadius = radius
          layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
      } else {
          let path = UIBezierPath(roundedRect: bounds,
                                  byRoundingCorners: corners,
                                  cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          layer.mask = mask
      }
  }
}
