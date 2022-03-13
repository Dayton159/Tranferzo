//
//  RegisterInteractorTests.swift
//  TranferzoTests
//
//  Created by Dayton on 13/03/22.
//

import XCTest
@testable import Tranferzo

class RegisterInteractorTests: XCTestCase {
  
  var mockRepository: MockRegisterRepository!
  var mockPresenter: MockRegisterPresenter!

  override func setUp() {
    super.setUp()
    mockRepository = MockRegisterRepository()
    mockPresenter = MockRegisterPresenter()
  }
  
  override func tearDown() {
    mockRepository = nil
    mockPresenter = nil
    super.tearDown()
  }
  
  // MARK: - Positive Case
  
  func test_RegisterUserSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.registerUser()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_RegisterUserSuccess_ReturnSuccessMessage() {
    let expResult = RegisterResponse.dummy.status.capitalized
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    
    sut.registerUser()
    XCTAssertEqual(mockPresenter.status, expResult)
  }
  
  func test_RegisterUserSuccess_ErrorNil() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    
    sut.registerUser()
    XCTAssertNil(mockPresenter.message)
  }
  
  func test_RegisterDataHadUsernamePasswordAndConfirmPassword_ValidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(username: "dummyUsername")
    sut.setRegisterData(password: "dummyPassword")
    sut.setRegisterData(confirmPass: "dummyPassword")
    
    XCTAssertTrue(mockPresenter.isValid)
  }
  
  // MARK: - Negative Case
  
  func test_RegisterUserFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.registerUser()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_RegisterUserFailed_SuccessMessageNil() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    
    sut.registerUser()
    XCTAssertNil(mockPresenter.status)
  }
  
  func test_RegisterUserFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    
    sut.registerUser()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
  
  func test_RegisterDataHasUsernameWithoutPasswordAndConfirm_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(username: "dummyUsername")
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  func test_RegisterDataHasPasswordWithoutUsernameAndConfirm_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(password: "dummyPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  func test_RegisterDataHasConfirmPassWithoutUsernameAndPassword_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(confirmPass: "dummyPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  func test_RegisterDataHasUsernameAndPassword_ButNoConfirmPass_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(username: "dummyUsername")
    sut.setRegisterData(password: "dummyPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  func test_RegisterDataHasUsernameAndConfirmPass_ButNoPassword_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(username: "dummyUsername")
    sut.setRegisterData(confirmPass: "dummyPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  func test_RegisterDataHasPasswordAndConfirmPassMatched_ButNoUsername_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(password: "dummyPassword")
    sut.setRegisterData(confirmPass: "dummyPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  
  func test_RegisterDataHasPasswordAndConfirmPass_ButNoUsernameAndUnmatchedPassword_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(password: "otherPassword")
    sut.setRegisterData(confirmPass: "dummyPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  func test_RegisterDataHasPasswordAndConfirmPass_ButNoUsernameAndUnmatchedConfirmPass_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(password: "dummyPassword")
    sut.setRegisterData(confirmPass: "otherPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  
  func test_RegisterDataHasUsernameAndPassword_ButUnmatchedConfirmPassword_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(username: "dummyUsername")
    sut.setRegisterData(password: "dummyPassword")
    sut.setRegisterData(confirmPass: "otherPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
  
  func test_RegisterDataHasUsernameAndConfirmPass_ButUnmatchedPassword_InvalidToLogin() {
    let sut = MockDI.init().provideRegisterUseCase(with: mockRepository, output: mockPresenter)
    sut.setRegisterData(username: "dummyUsername")
    sut.setRegisterData(password: "otherPassword")
    sut.setRegisterData(confirmPass: "dummyPassword")
    
    XCTAssertFalse(mockPresenter.isValid)
  }
}
