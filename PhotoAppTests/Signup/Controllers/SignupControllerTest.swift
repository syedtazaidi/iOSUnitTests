//
//  SignupControllerTest.swift
//  PhotoAppTests
//
//  Created by Taha Ali on 2022-04-28.
//

import XCTest
@testable import PhotoApp

class SignupControllerTest: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: SignupViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
    }
    
    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {

        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firstName Text field is not connected to IBOutlet in the Main storyboard")
        
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The Last Name Text field is not connected to IBOutlet in the Main storyboard")
        
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The Email Text field is not connected to IBOutlet in the Main storyboard")
        
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The Password Text field is not connected to IBOutlet in the Main storyboard")
        
        let passwordMatchTextField = try XCTUnwrap(sut.passwordMatchTextField, "The Password Match Text field is not connected to IBOutlet in the Main storyboard")
        
        
        XCTAssertEqual(firstNameTextField.text, "", "First Name Text Field not empty when ViewController initially loaded")
        XCTAssertEqual(lastNameTextField.text, "", "Last Name Text Field not empty when ViewController initially loaded")
        XCTAssertEqual(emailTextField.text, "", "Email Text Field not empty when ViewController initially loaded")
        XCTAssertEqual(passwordTextField.text, "", "Password Text Field not empty when ViewController initially loaded")
        XCTAssertEqual(passwordMatchTextField.text, "", "Repeat Password Text Field not empty when ViewController initially loaded")
        
    }
    
    func testSignupViewController_WhenCreated_HasSignupButtonAndClicked() throws {
        let signupButton: UIButton = try XCTUnwrap(sut.signupButton, "Signupbutton is not connected or created in the Main storyboard")
        let signButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside),"Signup button is not connected to any IBoutlet action")
        
        XCTAssertEqual(signButtonActions.count, 1)
        XCTAssertEqual(signButtonActions.first, "signupButtonClicked:", "NO function is connected to this Signup Button ")
    }
    
    func testSignupViewController_WhenSignupButtonTapped_InvokeSignupButtonProcess() throws {
        
        let formModelValidator = MockSignupFormModelValidator()
        let webservice = MockSignupWebService()
        let delegate = MockSignupViewDelegate()
        
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: formModelValidator,
                                                      signupWebService: webservice,
                                                      delegate: delegate)
        
        sut.signupPresenter = mockSignupPresenter
        
        //Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        //Assert
        
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled ,"ProcessUser Signup Method not called")
    }

}
