//
//  Constants.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import UIKit

struct Constants {
  
  struct Image {
    static let eye = UIImage(systemName: "eye.fill")
    static let eyeSlash = UIImage(systemName: "eye.slash.fill")
  }
  
  struct Color {
    static let error = UIColor(named: "redError")
    static let underline = UIColor(named: "underlineColor")
    static let disableBtn = UIColor(named: "secondaryYellow")
    static let activeBtn = UIColor(named: "primaryYellow")
    static let secondaryText = UIColor(named: "blackOut")
  }
  
  struct Font {
    static func novaRegular(_ size: CGFloat = 15) -> UIFont {
      guard let font = UIFont(name: "ProximaNovaA-Regular", size: size) else { fatalError("ProximaNovaA-Regular Not Found")}
      return font
    }

    static func novaBold(_ size: CGFloat = 15) -> UIFont {
      guard let font = UIFont(name: "ProximaNovaA-Bold", size: size) else { fatalError("ProximaNovaA-Bold Not Found")}
      return font
    }
  }
}
