//
//  BalanceRequestTests.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

import XCTest
import Combine
@testable import Tranferzo

class BalanceRequestTests: XCTestCase {
  
  var sut: MockAPIService!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    sut = MockAPIService()
    cancellables = []
  }
  
  override func tearDown() {
    sut = nil
    cancellables = nil
    super.tearDown()
  }
  
  func test_FetchBalanceSuccessful_ShouldReturnBalanceResponse() {
    guard let expResult = try? JSONDecoder().decode(BalanceResponse.self, from: DummyBalanceJSON.success.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    
    sut.dummyResponse = DummyBalanceJSON.success
    sut.expMethod = "GET"
    sut.expPathname = "/balance"
    
    let expectation = expectation(description: "Success Fetch Balance")
    let request = BalanceRequest()
    
    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with \(expResult), got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { result in
        XCTAssertEqual(result, expResult, "Balance Data \(result) Did not match expected value \(expResult)")
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchBalanceFailed_ShouldReturnErrorModel() {
    guard let response = try? JSONDecoder().decode(ErrorResponse.self, from: DummyBalanceJSON.failed.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    
    let expResult = APIServiceError.errorResponse(response).errorMessage
    
    sut.dummyResponse = DummyBalanceJSON.failed
    sut.expMethod = "GET"
    sut.expPathname = "/balance"
    sut.expError = response
    
    let expectation = expectation(description: "Failed Fetch Balance")
    let request = BalanceRequest()
    
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
        XCTFail("Expected to failed with \(expResult), got value \(result) instead")
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
}
