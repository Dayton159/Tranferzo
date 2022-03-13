//
//  RegisterRepositoryTests.swift
//  TranferzoTests
//
//  Created by Dayton on 13/03/22.
//

import XCTest
import Combine
@testable import Tranferzo

class RegisterRepositoryTests: XCTestCase {
  
  var mockDataSource: MockRegisterDataSource!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    mockDataSource = MockRegisterDataSource()
    cancellables = []
  }
  
  override func tearDown() {
    mockDataSource = nil
    cancellables = nil
    super.tearDown()
  }
  
  func test_RegisterUserSuccess_ReturnSuccessStatus() {
    let expResult = RegisterResponse.dummy.status.capitalized
    
    let expectation = expectation(description: "Success Register User")
    let sut = MockDI.init().provideRegisterRepository(with: mockDataSource)
    let registerData = AuthData.dummy
    
    sut.registerUser(data: registerData)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with \(expResult), got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { result in
        XCTAssertEqual(result, expResult, "Register Success Data \(result) Did not match expected value \(expResult)")
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_RegisterUserFailed_ReturnError() {
    mockDataSource.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    
    let expectation = expectation(description: "User Registration Failed")
    let sut = MockDI.init().provideRegisterRepository(with: mockDataSource)
    let registerData = AuthData.dummy
    
    sut.registerUser(data: registerData)
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
