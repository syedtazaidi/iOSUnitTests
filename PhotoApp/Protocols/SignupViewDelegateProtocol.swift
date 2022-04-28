//
//  SignupViewDelegateProtocol.swift
//  PhotoApp
//
//  Created by Taha Ali on 2022-04-27.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func successfulSignup()
    func errorHandler(error: SignupError)
}
