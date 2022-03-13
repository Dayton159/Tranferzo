//
//  DashboardRepositoryTests.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

import XCTest
import Combine
@testable import Tranferzo

class DashboardRepositoryTests: XCTestCase {
  
  var mockBalanceDS: MockBalanceDataSource!
  var mockTransactionDS: MockTransactionDataSource!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    mockBalanceDS = MockBalanceDataSource()
    mockTransactionDS = MockTransactionDataSource()
    cancellables = []
  }
  
  override func tearDown() {
    mockBalanceDS = nil
    mockTransactionDS = nil
    cancellables = nil
    super.tearDown()
  }
  
  // MARK: - Positive Case
  
  func test_FetchBalanceSuccess_ReturnBalanceModel() {
    let expResult = BalanceModel.dummy
    let expectation = expectation(description: "Success Map to Domain Balance")
    
    let sut = MockDI.init().provideDashboardRepository(balance: mockBalanceDS, transaction: mockTransactionDS)
    
    sut.getBalance()
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
  
  func test_FetchTransactionSuccess_ReturnTransactionEntity() {
    let expResult = TransactionEntity.dummyList
    let expectation = expectation(description: "Success Map to Transaction Entity")
    
    let sut = MockDI.init().provideDashboardRepository(balance: mockBalanceDS, transaction: mockTransactionDS)
    
    sut.getTransaction()
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
  
  // MARK: - Negative Case
  
  func test_FetchBalanceFailed_ReturnError() {
    mockBalanceDS.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    
    let expectation = expectation(description: "Failed Fetching Balance")
    let sut = MockDI.init().provideDashboardRepository(balance: mockBalanceDS, transaction: mockTransactionDS)
    
    sut.getBalance()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, expResult.errorMessage, "Error Message Data \(error.errorMessage) Did not match expected value \(expResult.errorMessage)")
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to failed with \(expResult), got value \(result) instead")
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchTransactionFailed_ReturnError() {
    mockTransactionDS.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    
    let expectation = expectation(description: "Failed Fetching Transactions")
    let sut = MockDI.init().provideDashboardRepository(balance: mockBalanceDS, transaction: mockTransactionDS)
    
    sut.getTransaction()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, expResult.errorMessage, "Error Message Data \(error.errorMessage) Did not match expected value \(expResult.errorMessage)")
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
