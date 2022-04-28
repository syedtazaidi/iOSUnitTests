//
//  MockSignupWebService.swift
//  PhotoAppTests
//
//  Created by Taha Ali on 2022-04-27.
//

import Foundation
@testable import PhotoApp

class MockSignupWebService:SignupWebServiceProtocol {
    var isSignupMethodCalled : Bool =  false
    var shouldReturnError : Bool =  false
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        isSignupMethodCalled = true
        
        if shouldReturnError {
            completionHandler(nil, SignupError.failedRequest(description: "Signup request was not successful"))
        }
        else {
            let signupResponseModel = SignupResponseModel(status: "ok")
            completionHandler(signupResponseModel,nil)
        }

    }

}
