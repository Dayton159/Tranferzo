//
//  DateFormatter.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import Foundation

extension Foundation.DateFormatter {
  @nonobjc static var standardDateFormatter: Foundation.DateFormatter = {
    let dateFormatter = Foundation.DateFormatter()
    return dateFormatter
  }()

  static func dateFormatter(_ format: String) -> Foundation.DateFormatter {
    let dateFormatter = standardDateFormatter
    dateFormatter.dateFormat = format
    return dateFormatter
  }
}

enum DateFormatter {
  case JSONResponse
  case yearOnBack

  func formatter() -> Foundation.DateFormatter {
    switch self {
    case .JSONResponse:
      return dateFormatter(string: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    case .yearOnBack:
      return dateFormatter(string: "dd MMM yyyy")
    }
  }

  private func dateFormatter(string: String) -> Foundation.DateFormatter {
    let localFormatter = Foundation.DateFormatter.dateFormatter(string)
    localFormatter.locale = Locale.current
    return localFormatter
  }

  func stringFromDate(_ date: Date?) -> String? {
    guard let safeDate = date else { return nil }
    return self.formatter().string(from: safeDate)
  }

  func dateFromString(_ string: String) -> Date? {
    return self.formatter().date(from: string)
  }
}
