//
//  SignupFormModel.swift
//  PhotoApp
//
//  Created by Taha Ali on 2022-04-27.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    
}
