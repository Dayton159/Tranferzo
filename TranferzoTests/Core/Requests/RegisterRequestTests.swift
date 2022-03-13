//
//  RegisterRequestTests.swift
//  TranferzoTests
//
//  Created by Dayton on 13/03/22.
//

import XCTest
import Combine
@testable import Tranferzo

class RegisterRequestTests: XCTestCase {

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
  
  func test_RegisterRequestSuccessful_ShouldReturnRegisterResponse() {
    guard let expResult = try? JSONDecoder().decode(RegisterResponse.self, from: DummyRegisterJSON.success.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    
    sut.dummyResponse = DummyRegisterJSON.success
    sut.expMethod = "POST"
    sut.expPathname = "/register"
    
    let expectation = expectation(description: "Success Register User")
    let registerData = AuthData(username: "someUsername", password: "somePassword")
    let request = RegisterRequest(registerData: registerData)
    
    API(apiService: sut)
      .fetch(request)
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
  
  func test_RegisterRequestFailed_ShouldReturnErrorModel() {
    guard let response = try? JSONDecoder().decode(ErrorResponse.self, from: DummyRegisterJSON.failed.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    let expResult = APIServiceError.errorResponse(response).errorMessage
    
    sut.dummyResponse = DummyRegisterJSON.success
    sut.expMethod = "POST"
    sut.expPathname = "/register"
    sut.expError = response
    
    let expectation = expectation(description: "Failed Register User")
    let registerData = AuthData(username: "someUsername", password: "somePassword")
    let request = RegisterRequest(registerData: registerData)
    
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
