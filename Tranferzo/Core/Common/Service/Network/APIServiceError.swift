//
//  APIServiceError.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

enum APIServiceError: Error {
  case cannotMapToObject
  case noInternetConnection
  
  case custom(Error)
  case errorResponse(ErrorResponse)
  
  var errorMessage: String {
    switch self {
    case .cannotMapToObject:
      return "Failed to Display data"
    case .noInternetConnection:
      return "Unable to Access Server. Please Check Your Network Connection"
    case .custom(let error):
      return error.localizedDescription.capitalized
    case .errorResponse(let response):
      return response.error
    }
  }
}
