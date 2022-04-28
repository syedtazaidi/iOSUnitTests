//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by Taha Ali on 2022-04-27.
//

import Foundation
import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {

    var expectation : XCTestExpectation?
    var successfulSignupCounter: Int  = 0
    var errorHandlerCounter: Int  = 0
    var signupError: SignupError?
    
    
    func successfulSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        self.signupError = error
        errorHandlerCounter += 1
        expectation?.fulfill()
    }

    
}
