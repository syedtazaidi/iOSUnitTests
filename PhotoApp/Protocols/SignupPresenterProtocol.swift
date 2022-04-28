//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by Taha Ali on 2022-04-28.
//

import Foundation


protocol SignupPresenterProtocol: AnyObject {
    
    init(formModelValidator: SignupModelValidatorProtocol,
         signupWebService: SignupWebServiceProtocol,
         delegate:  SignupViewDelegateProtocol)
    
    func processUserSignup(form formModel: SignupFormModel)
    
}
