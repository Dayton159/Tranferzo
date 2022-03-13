//
//  APINetworkTests.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

import XCTest
import Combine
@testable import Tranferzo

class APINetworkTests: XCTestCase {
  
  var sut: APIService!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    let config = URLSessionConfiguration.default
    config.protocolClasses = [MockURLProtocol.self]
    let urlSession = URLSession(configuration: config)
    sut = URLSessionService(session: urlSession)
    cancellables = []
  }
  
  override func tearDown() {
    sut = nil
    cancellables = nil
    MockURLProtocol.data = nil
    super.tearDown()
  }
  
  func test_FetchRequestSuccessful_ShouldReturnResponseModel() {
    let dummyResponse = """
{
    "status": "success",
    "accountNo": "2970-111-3648",
    "balance": 61.46
}
"""
    MockURLProtocol.responseWithStatusCode(code: 200, data: dummyResponse.data(using: .utf8))
    
    guard let expResult = try? JSONDecoder().decode(MockResponse.self, from: dummyResponse.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    
    let request = MockAPIRequest()
    let expectation = expectation(description: "Success Request With Response")
    
    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with \(expResult), got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { result in
        XCTAssertEqual(result, expResult, "Fetch Success Data \(result) Did not match expected value \(expResult)")
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchRequestSuccessfulWithoutData_ShouldReturnMappingError() {
    MockURLProtocol.responseWithStatusCode(code: 204, data: nil)
    
    let request = MockAPIRequest()
    let expectation = expectation(description: "Success Request Without Data")
    let expResult = APIServiceError.cannotMapToObject.errorMessage
    
    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, expResult, "Error Message Data \(error.errorMessage) Did not match expected value \(expResult)")
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchRequestFailedWithErrorResponse_ShouldReturnErrorModel() {
    let expResult = "Jwt Malformed"
    let dummyErrorResponse = """
{
    "status": "failed",
    "error": {
        "name": "JsonWebTokenError",
        "message": "jwt malformed"
    }
}
"""
    
    MockURLProtocol.responseWithStatusCode(code: 404, data: dummyErrorResponse.data(using: .utf8))

    let request = MockAPIRequest()
    let expectation = expectation(description: "Failed Request With Response")

    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, expResult, "Error Message Data \(error.errorMessage) Did not match expected value \(expResult)")
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchRequestFailedWithError_ShouldReturnCustomError() {
    MockURLProtocol.responseWithFailure()
    
    let request = MockAPIRequest()
    let expectation = expectation(description: "Failed Request With Error")
    let expResult = APIServiceError.custom(MockError.none).errorMessage
    
    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, expResult, "Error Message Data \(error.errorMessage) Did not match expected value \(expResult)")
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchRequestFailedWithoutConnection_ShouldReturnConnectionError() {
    MockURLProtocol.responseWithStatusCode(code: 503, data: nil)
    
    let request = MockAPIRequest()
    let expectation = expectation(description: "Failed Request Without Connection")
    let expResult = APIServiceError.noInternetConnection.errorMessage
    
    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, expResult, "Error Message Data \(error.errorMessage) Did not match expected value \(expResult)")
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchRequestSuccessButFailedToMap_ShouldReturnMapError() {
    let expResult = APIServiceError.cannotMapToObject.errorMessage
    let dummyErrorResponse = """
{
    "statusResponse": "failed",
    "errorResponse": {
        "nameResponse": "JsonWebTokenError",
        "messageResponse": "jwt malformed"
    }
}
"""
    
    MockURLProtocol.responseWithStatusCode(code: 200, data: dummyErrorResponse.data(using: .utf8))

    let request = MockAPIRequest()
    let expectation = expectation(description: "Fetch Success But Failed to Decode data")

    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, expResult, "Error Message Data \(error.errorMessage) Did not match expected value \(expResult)")
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchRequestFailedAndFailedToMapErrorResponse_ShouldReturnMapError() {
    let expResult = APIServiceError.cannotMapToObject.errorMessage
    let dummyErrorResponse = """
{
    "statusResponse": "failed",
    "errorResponse": {
        "nameResponse": "JsonWebTokenError",
        "messageResponse": "jwt malformed"
    }
}
"""
    
    MockURLProtocol.responseWithStatusCode(code: 404, data: dummyErrorResponse.data(using: .utf8))

    let request = MockAPIRequest()
    let expectation = expectation(description: "Fetch Success But Failed to Decode data")

    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, expResult, "Error Message Data \(error.errorMessage) Did not match expected value \(expResult)")
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
}
