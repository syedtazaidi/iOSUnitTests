//
//  SignupFormModelValidator.swift
//  PhotoAppTests
//
//  Created by Taha Ali on 2022-04-26.
//

import XCTest
@testable import PhotoApp

class SignupFormModelValidatorTests: XCTestCase {
    
    var sut : SignupFormModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testSignupFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        //Given
        //When
        let isFirstNameValid = sut.isFirstNameValid(firstName:"Syed Taha")
        
        //Then
        
        XCTAssertTrue(isFirstNameValid, "Suppose to return TRUR but its returning FALSE")
    }
    
    func testSignupFormModelValidator_WhenShortFirstNameProvided_ShouldReturnFalse() {
        //Given
        //When
        let isFirstNameValid = sut.isFirstNameValid(firstName:"S")
        
        //Then
        
        XCTAssertFalse(isFirstNameValid, "Suppose to return FALSE but its returning TRUE")
    }
    
    func testSignupFormModelValidator_WhenLongFirstNameProvided_ShouldReturnFalse() {
        //Given
        //When
        let isFirstNameValid = sut.isFirstNameValid(firstName:"Syed Taha Ali Zaidi Syed Taha Ali Zaidi")
        
        //Then
        
        XCTAssertFalse(isFirstNameValid, "Suppose to return FALSE but its returning TRUE because the first name is too long")
    }
    
    func testSignupFormModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
        //Given
        //When
        let isLastNameNameValid = sut.isLastNameValid(lastName: "Zaidi")
        
        //Then
        
        XCTAssertTrue(isLastNameNameValid, "Suppose to return TRUE but its returning FALSE")
    }
    
    func testSignupFormModelValidator_WhenShortLastNameProvided_ShouldReturnFalse() {
        //Given
        //When
        let isLastNameNameValid = sut.isLastNameValid(lastName: "Z")
        
        //Then
        
        XCTAssertFalse(isLastNameNameValid, "Suppose to return False but its returning TRUE")
    }
    
    
    func testSignupFormModelValidator_WhenLongLastNameProvided_ShouldReturnFalse() {
        //Given
        //When
        let isLastNameNameValid = sut.isLastNameValid(lastName: "Zaidi Zaidi Zaidi Zaidi Zaidi Zaidi")
        
        //Then
        
        XCTAssertFalse(isLastNameNameValid, "Suppose to return FALSE but its returning TRUE")
    }

}
