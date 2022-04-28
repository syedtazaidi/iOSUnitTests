//
//  SignupWebService.swift
//  PhotoApp
//
//  Created by Taha Ali on 2022-04-27.
//

import Foundation
import UIKit

class SignupWebService : SignupWebServiceProtocol {
    
    private var urlString: String
    private var urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void){
        guard let url = URL(string: urlString) else {
            completionHandler(nil,SignupError.invalidRequestURLStringError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error =  error {
                completionHandler(nil, SignupError.failedRequest(description: error.localizedDescription))
                return
            }
            
            if let data = data , let signupResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                print(signupResponseModel)
                completionHandler(signupResponseModel, nil)
            }else {
                completionHandler(nil,SignupError.responseModelParsingError)
            }
        }
        
        dataTask.resume()
        
    }
}
