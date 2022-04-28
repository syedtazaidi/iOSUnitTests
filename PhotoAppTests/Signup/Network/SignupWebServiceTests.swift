//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by Taha Ali on 2022-04-27.
//

import XCTest
@testable import PhotoApp

class SignupWebServiceTests: XCTestCase {
    var sut: SignupWebService!
    var signupFormRequestModel: SignupFormRequestModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupURL,
                               urlSession: urlSession)
        
        signupFormRequestModel = SignupFormRequestModel(firstName: "Syed", lastName: "Zaidi", email: "syedtazaidi@gmail.com", password: "Atrium12")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        signupFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        let jsonString = "{\"status\": \"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup WebService Response Expectation")
        
        sut.signup(withForm: signupFormRequestModel) { (signupFormResponseModel, error) in
            //Assert
            XCTAssertEqual(signupFormResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
        
    }
    
    func testSignupWebService_WhenReceiveDifferentJSONResponse_ErrorTookPlace() {
        let jsonString = "{\"path\": \"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Error for different JSOn response")
        
        sut.signup(withForm: signupFormRequestModel) { (signupFormResponseModel, error) in
            //Assert
            XCTAssertNil(signupFormResponseModel , "Expecting Response Model to nil but its returning something")
            XCTAssertEqual(error, SignupError.responseModelParsingError)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyURLString_ErrorTookPlace() {
        
        let expectation = self.expectation(description: "An empty URL String is passed")
        
        sut = SignupWebService(urlString: "")
        
        sut.signup(withForm: signupFormRequestModel) { responseModel, error in
            XCTAssertNil(responseModel , "Expecting Response Model to nil but its returning something")
            XCTAssertEqual(error, SignupError.invalidRequestURLStringError)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testSignupWebService_WhenURlRequestFails_ErrorTookPlace() {
        
        let myExpectation = self.expectation(description: "A failed request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error =  SignupError.failedRequest(description: errorDescription)
        
        sut.signup(withForm: signupFormRequestModel) { (responseModel, error) in
            XCTAssertNil(responseModel , "Expecting Response Model to nil but its returning something")
            XCTAssertEqual(error, SignupError.failedRequest(description: errorDescription), "The signup() method did not return an expected error for the Failed Request")
            // XCTAssertEqual(error?.localizedDescription, errorDescription)
            myExpectation.fulfill()
        }
        
        self.wait(for: [myExpectation], timeout: 2)
    }
    
}

