//
//  LoginRequestTests.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

import XCTest
import Combine
@testable import Tranferzo

class LoginRequestTests: XCTestCase {
  
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
  
  func test_LoginRequestSuccessful_ShouldReturnLoginResponse() {
    guard let expResult = try? JSONDecoder().decode(LoginResponse.self, from: DummyLoginJSON.success.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    
    sut.dummyResponse = DummyLoginJSON.success
    sut.expMethod = "POST"
    sut.expPathname = "/login"
    
    let expectation = expectation(description: "Success Login User")
    let loginData = AuthData(username: "someUsername", password: "somePassword")
    let request = LoginRequest(loginData: loginData)
    
    API(apiService: sut)
      .fetch(request)
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
  
  func test_LoginRequestFailed_ShouldReturnErrorModel() {
    guard let response = try? JSONDecoder().decode(ErrorResponse.self, from: DummyLoginJSON.failed.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    let expResult = APIServiceError.errorResponse(response).errorMessage

    sut.dummyResponse = DummyLoginJSON.failed
    sut.expMethod = "POST"
    sut.expPathname = "/login"
    sut.expError = response
    
    let expectation = expectation(description: "Failed Login User")
    let loginData = AuthData(username: "someUsername", password: "somePassword")
    let request = LoginRequest(loginData: loginData)
    
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
