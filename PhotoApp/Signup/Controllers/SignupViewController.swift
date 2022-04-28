//
//  SignupViewController.swift
//  PhotoApp
//
//  Created by Taha Ali on 2022-04-28.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordMatchTextField: UITextField!
    
    var signupPresenter : SignupPresenterProtocol?
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if signupPresenter == nil {
            let formModelValidator = SignupFormModelValidator()
            let webService = SignupWebService(urlString: SignupConstants.signupURL)
            
            signupPresenter = SignupPresenter(formModelValidator: formModelValidator,
                                              signupWebService: webService,
                                              delegate: self)
        }

    }

    
    @IBAction func signupButtonClicked(_ sender: Any) {
        let formModel = SignupFormModel(firstName: firstNameTextField.text ?? "",
                                        lastName: lastNameTextField.text ?? "",
                                        email: emailTextField.text ?? "",
                                        password: passwordTextField.text ?? "",
                                        repeatPassword: passwordMatchTextField.text ?? "")
        signupPresenter?.processUserSignup(form: formModel)
    }
}

extension SignupViewController : SignupViewDelegateProtocol {
    func successfulSignup() {
        // TODO:
    }
    
    func errorHandler(error: SignupError) {
        // TODO:
    }
}
