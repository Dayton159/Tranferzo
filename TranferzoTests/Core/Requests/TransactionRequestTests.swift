//
//  TransactionRequestTests.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

import XCTest
import Combine
@testable import Tranferzo

class TransactionRequestTests: XCTestCase {

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
  
  func test_FetchTransactionSuccessful_ShouldReturnTransactionResponse() {
    guard let expResult = try? JSONDecoder().decode(TransactionListResponse.self, from: DummyTransactionJSON.success.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    
    sut.dummyResponse = DummyTransactionJSON.success
    sut.expMethod = "GET"
    sut.expPathname = "/transactions"
    
    let expectation = expectation(description: "Success Fetch Transactions")
    let request = TransactionRequest()
    
    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with \(expResult), got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { result in
        XCTAssertEqual(result, expResult, "Transaction Data \(result) Did not match expected value \(expResult)")
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchTransactionFailed_ShouldReturnErrorModel() {
    guard let response = try? JSONDecoder().decode(ErrorResponse.self, from: DummyTransactionJSON.failed.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    
    let expResult = APIServiceError.errorResponse(response).errorMessage
    
    sut.dummyResponse = DummyTransactionJSON.failed
    sut.expMethod = "GET"
    sut.expPathname = "/transactions"
    sut.expError = response
    
    let expectation = expectation(description: "Failed Fetch Transaction")
    let request = TransactionRequest()
    
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
