//
//  DashboardInteractorTests.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

import XCTest
@testable import Tranferzo

class DashboardInteractorTests: XCTestCase {

  var mockRepository: MockDashboardRepository!
  var mockPresenter: MockDashboardPresenter!

  override func setUp() {
    super.setUp()
    mockRepository = MockDashboardRepository()
    mockPresenter = MockDashboardPresenter()
  }
  
  override func tearDown() {
    mockRepository = nil
    mockPresenter = nil
    super.tearDown()
  }
  
  // MARK: - Positive Case
  
  // Balance
  func test_FetchBalanceSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getBalance()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_FetchBalanceSuccess_ReturnBalanceModel() {
    let expResult = BalanceModel.dummy
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getBalance()
    XCTAssertEqual(mockPresenter.balance, expResult)
  }
  
  func test_FetchBalanceSuccess_ErrorNil() {
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getBalance()
    XCTAssertNil(mockPresenter.message)
  }
  
  // Transaction
  func test_FetchTransactionSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getTransaction()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_FetchTransactionSuccess_ReturnTransactionModel() {
    let expResult = TransactionModel.dummyList
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getTransaction()
    XCTAssertEqual(mockPresenter.transactions, expResult)
  }
  
  func test_FetchTransactionSuccess_ErrorNil() {
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getTransaction()
    XCTAssertNil(mockPresenter.message)
  }
  
  // MARK: - Negative Case
  
  // Balance
  func test_FetchBalanceFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getBalance()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_FetchBalanceFailed_BalanceModelNil() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getBalance()
    XCTAssertNil(mockPresenter.balance)
  }
  
  func test_FetchBalanceFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getBalance()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
  
  // Transaction
  func test_FetchTransactionFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getTransaction()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_FetchTransactionFailed_ModelArrayEmpty() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getTransaction()
    XCTAssertTrue(mockPresenter.transactions.isEmpty)
  }
  
  func test_FetchTransactionFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideDashboardUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getTransaction()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
}
