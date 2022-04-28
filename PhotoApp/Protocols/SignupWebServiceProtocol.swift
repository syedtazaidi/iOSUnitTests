//
//  SignupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by Taha Ali on 2022-04-27.
//

import Foundation

protocol SignupWebServiceProtocol {
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
