//
//  LoginRepositoryTests.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

import XCTest
import Combine
@testable import Tranferzo

class LoginRepositoryTests: XCTestCase {
  
  var mockDataSource: MockLoginDataSource!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    mockDataSource = MockLoginDataSource()
    cancellables = []
  }
  
  override func tearDown() {
    mockDataSource = nil
    cancellables = nil
    super.tearDown()
  }
  
  func test_LoginUserSuccess_ReturnSuccessStatus() {
    let expResult = LoginResponse.dummy.status.capitalized
    
    let expectation = expectation(description: "Success Login User")
    let sut = MockDI.init().provideLoginRepository(with: mockDataSource)
    let loginData = AuthData.dummy
    
    sut.authenticateUser(data: loginData)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with \(expResult), got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { result in
        XCTAssertEqual(result, expResult, "Login Success Data \(result) Did not match expected value \(expResult)")
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_LoginUserFailed_ReturnError() {
    mockDataSource.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    
    let expectation = expectation(description: "User Login Failed")
    let sut = MockDI.init().provideLoginRepository(with: mockDataSource)
    let loginData = AuthData.dummy
    
    sut.authenticateUser(data: loginData)
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
