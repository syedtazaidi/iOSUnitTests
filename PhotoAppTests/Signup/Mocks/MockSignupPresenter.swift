//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by Taha Ali on 2022-04-28.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProtocol {
    
    var processUserSignupCalled: Bool = false
    required init(formModelValidator: SignupModelValidatorProtocol, signupWebService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol) {
        //
    }
    
    func processUserSignup(form formModel: SignupFormModel) {
        processUserSignupCalled = true
    }
    
}
