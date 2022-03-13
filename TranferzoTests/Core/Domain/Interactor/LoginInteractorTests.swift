//
//  LoginInteractorTests.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

import XCTest
@testable import Tranferzo

class LoginInteractorTests: XCTestCase {
  
  var mockRepository: MockLoginRepository!
  var mockPresenter: MockLoginPresenter!

  override func setUp() {
    super.setUp()
    mockRepository = MockLoginRepository()
    mockPresenter = MockLoginPresenter()
  }
  
  override func tearDown() {
    mockRepository = nil
    mockPresenter = nil
    super.tearDown()
  }
  
  // MARK: - Positive Case
  
  func test_LoginUserSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideLoginUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.authenticateUser()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_LoginUserSuccess_ReturnSuccessMessage() {
    let expResult = LoginResponse.dummy.status.capitalized
    let sut = MockDI.init().provideLoginUseCase(with: mockRepository, output: mockPresenter)
    
    sut.authenticateUser()
    XCTAssertEqual(mockPresenter.status, expResult)
  }
  
  func test_LoginUserSuccess_ErrorNil() {
    let sut = MockDI.init().provideLoginUseCase(with: mockRepository, output: mockPresenter)
    
    sut.authenticateUser()
    XCTAssertNil(mockPresenter.message)
  }
  
  func test_LoginDataHasUsernameAndPassword_ValidToLogin() {
    let sut = MockDI.init().provideLoginUseCase(with: mockRepository, output: mockPresenter)
    sut.setLoginData(username: "dummyUsername")
    sut.setLoginData(password: "dummyPassword")
    
    XCTAssertTrue(mockPresenter.isValid)
  }
  
  // MARK: - Negative Case
  
  func test_LoginUserFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideLoginUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.authenticateUser()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_LoginUserFailed_SuccessMessageNil() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideLoginUseCase(with: mockRepository, output: mockPresenter)
    
    sut.authenticateUser()
    XCTAssertNil(mockPresenter.status)
  }
  
  func test_LoginUserFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideLoginUseCase(with: mockRepository, output: mockPresenter)
    
    sut.authenticateUser()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
  
  func test_LoginDataHasUsernameWithoutPassword_InvalidToLogin() {
    let sut = MockDI.init().provideLoginUseCase(with: mockRepository, output: mockPresenter)
    sut.setLoginData(username: "dummyUsername")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  func test_LoginDataHasPasswordWithoutUsername_InvalidToLogin() {
    let sut = MockDI.init().provideLoginUseCase(with: mockRepository, output: mockPresenter)
    sut.setLoginData(password: "dummyPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
}
