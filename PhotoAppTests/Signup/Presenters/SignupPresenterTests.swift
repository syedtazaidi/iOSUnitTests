//
//  SignupPresenterTests.swift
//  PhotoAppTests
//
//  Created by Taha Ali on 2022-04-27.
//

import XCTest
@testable import PhotoApp

class SignupPresenterTests: XCTestCase {
    
    var signupFormModel: SignupFormModel!
    var mockSignupFormModelValidator: MockSignupFormModelValidator!
    var mockSignupWebService : MockSignupWebService!
    var sut: SignupPresenter!
    var mockSignupViewDelegate:  MockSignupViewDelegate!
 
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signupFormModel = SignupFormModel(firstName: "Syed",
                                              lastName: "Zaidi",
                                              email:"syedtazaidi@gmail.com",
                                              password:"Atrium12",
                                              repeatPassword: "Atrium12")
        
        mockSignupFormModelValidator = MockSignupFormModelValidator()
        mockSignupWebService = MockSignupWebService()
        mockSignupViewDelegate = MockSignupViewDelegate()
        sut = SignupPresenter(formModelValidator: mockSignupFormModelValidator,
                                  signupWebService: mockSignupWebService,
                                    delegate: mockSignupViewDelegate)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signupFormModel = nil
        mockSignupFormModelValidator = nil
        mockSignupWebService = nil
        sut = nil
        mockSignupViewDelegate = nil
    }

    func testSignupPresenter_WhenInformationProvided_WillValidateAllFields() {
        sut.processUserSignup(form: signupFormModel)
    
        XCTAssertTrue(mockSignupFormModelValidator.isFirstNameValidated, "First Name was not validated")
        XCTAssertTrue(mockSignupFormModelValidator.isLastNameValidated,"Last Name was not validated")
        XCTAssertTrue(mockSignupFormModelValidator.isEmailValidated, "Email was not validated")
        XCTAssertTrue(mockSignupFormModelValidator.isPasswordValidated, "Password was not validated")
        XCTAssertTrue(mockSignupFormModelValidator.isPasswordMatchValidated, "Password Match was not validated")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCalledSignupMethod() {
        sut.processUserSignup(form: signupFormModel)
        
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "The Sign up method is not called")
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessful_CallsSuccessOnViewDelegate() {
        
        let myExpectation = self.expectation(description: "Expected the successfulSignup() method to be called")
        mockSignupViewDelegate.expectation = myExpectation
        
        sut.processUserSignup(form: signupFormModel)
            
        self.wait(for: [myExpectation], timeout: 2)
        
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1)
    }
    
    
    func testSignupPresenter_WhenSignupOperationFails_CallsErrorOnViewDelegate() {
        
        let myExpectation = self.expectation(description: "Expected the errorHandler() method to be called")
        mockSignupViewDelegate.expectation = myExpectation
        mockSignupWebService.shouldReturnError = true

        sut.processUserSignup(form: signupFormModel)
    
        self.wait(for: [myExpectation], timeout: 2)
        
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 0)
        XCTAssertNotNil(mockSignupViewDelegate.signupError)
        
    }

}
