//
//  SignupErrors.swift
//  PhotoApp
//
//  Created by Taha Ali on 2022-04-27.
//

import Foundation


enum SignupError : LocalizedError, Equatable {
    
    case responseModelParsingError
    case invalidRequestURLStringError
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidRequestURLStringError, .responseModelParsingError:
            return ""
        }
    }
}
