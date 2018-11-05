//
//  SignUpViewController.swift
//  SnapchatProject
//
//  Created by Daniel Phiri on 10/13/17. Modified by Yi.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import UIKit
import Firebase

// Sign up user
class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordVerificationTextField: UITextField!
    
    var userEmail = ""
    var userName = ""
    var userPassword = ""
    var userVerifiedPassWord = ""
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let name = nameTextField.text else { return }
        guard let verifiedPassword = passwordVerificationTextField.text else { return }
        if email == "" || password == "" || name == "" || verifiedPassword == "" {
            incompleteInfoAlert()
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    // edit current user display name
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges { (error) in
                        if error == nil {
                                // The user account has been successfully created. Now, update the user's name in
                                // firebase and then perform a segue to the main page. Note,
                                let alertController = UIAlertController(title: SnapCloneConstants.signupSuccess, message: error?.localizedDescription, preferredStyle: .alert)
                                self.present(alertController, animated: true, completion: {
                                    self.performSegue(withIdentifier: SnapCloneConstants.segueSignUpToMainPage, sender: self)
                                })
                            }
                        }
                } else if password != verifiedPassword {
                    self.passwordVerifyAlert()
                } else {
                    if let error = error {
                        self.signupErrorAlert(with: error)
                    }
                }
            }
        }
    }

    private func incompleteInfoAlert() {
        let alertController = UIAlertController(title: SnapCloneConstants.formEror, message: SnapCloneConstants.formIncomplete, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: SnapCloneConstants.ok, style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func passwordVerifyAlert() {
        let alertController = UIAlertController(title: SnapCloneConstants.verificationError, message: SnapCloneConstants.passwordMismatch, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: SnapCloneConstants.ok, style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.passwordVerificationTextField.textColor = UIColor.red
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func signupErrorAlert(with error: Error) {
        let alertController = UIAlertController(title: SnapCloneConstants.signupError, message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: SnapCloneConstants.ok, style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordVerificationTextField.delegate = self
    }
    
    // after end editing, assign textfield variable into field info
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else if textField == self.passwordTextField {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        } else if textField == self.nameTextField {
            if textField.text != nil {
                self.userName = textField.text!
            }
        } else if textField == self.passwordVerificationTextField {
            if textField.text != nil {
                self.userVerifiedPassWord = textField.text!
            }
        }
    }
}
