//
//  Double+Extension.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import Foundation

extension Double {
  func asCurrency(country: Country = .singapore, currency: String? = nil) -> String {
      let formatter = NumberFormatter()
      formatter.locale = Locale(identifier: country.rawValue)
      formatter.currencySymbol = currency
      formatter.numberStyle = .currency
      let returnedValue = formatter.string(from: NSNumber(value: self))
      return returnedValue ?? ""
  }
}
