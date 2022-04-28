//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by Taha Ali on 2022-04-27.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol {
    
    private var formModelValidator:  SignupModelValidatorProtocol
    private var signupWebService: SignupWebServiceProtocol
    private weak var delegate:  SignupViewDelegateProtocol?
    
    required init(formModelValidator: SignupModelValidatorProtocol,
         signupWebService: SignupWebServiceProtocol,
         delegate:  SignupViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.signupWebService = signupWebService
        self.delegate = delegate
    }
    
    func processUserSignup(form formModel: SignupFormModel) {
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            return 
        }
        
        if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
            return
        }
        
        if !formModelValidator.isPasswordValid(password: formModel.password){
            return
        }
        
        if !formModelValidator.isValidEmailFormat(email: formModel.email){
            return
        }
        
        if !formModelValidator.doPasswordsMatch(password: formModel.password, repeatPassword: formModel.repeatPassword){
            return
        }
        
        let requestModel = SignupFormRequestModel(firstName: formModel.firstName,
                                                  lastName: formModel.lastName,
                                                  email: formModel.email,
                                                  password:formModel.password)
        
        signupWebService.signup(withForm: requestModel) { [weak self] response, error in
            if let error = error {
                self?.delegate?.errorHandler(error: error)
                return
            }
            if let _ = response {
                self?.delegate?.successfulSignup()
            }
        }
    }
}
