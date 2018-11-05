//
//  LogInViewController.swift
//  SnapchatProject
//
//  Created by Daniel Phiri on 10/13/17. Modified by Yi.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import UIKit
import Firebase

// login in the user
class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var userEmail = ""
    var userPassword = ""
    
    @IBAction func logInPressed(_ sender: UIButton) {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        
        if emailText == "" || passwordText == "" {
            lackInformationAlert()
        } else {
            // email and password fields are not blank, let's try logging in the user!
            // you'll need to use `emailText` and `passwordText`, and a method found in this
            Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                if error == nil {
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: SnapCloneConstants.segueLogInToMainPage, sender: self)
                } else {
                    // present error in alert format if login fails with error
                    if let error = error {
                        self.failLoginAlert(with: error)
                    }
                }
            }
        }
       
    }
    
    //Alert to tell the user that there was an error because they didn't fill anything in the textfields
    private func lackInformationAlert() {
        let alertController = UIAlertController(title: SnapCloneConstants.loginError, message: SnapCloneConstants.missingInfo, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: SnapCloneConstants.ok, style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Alert with fail to login error
    private func failLoginAlert(with error: Error) {
        let alertController = UIAlertController(title: SnapCloneConstants.loginError, message:
            error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: SnapCloneConstants.ok, style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // navigate to sign up page
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier:SnapCloneConstants.segueLogInToSignUp, sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }

  
    // Authenticate users automatically if they already signed in earlier.
    // Just check if the current user is nil using firebase and if not, perform a segue.
    override func viewDidAppear(_ animated: Bool) {
       Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: SnapCloneConstants.segueLogInToMainPage, sender: self)
            }
        }
    }

    // Called when we unwind from the ChooseThreadViewController
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        }
    }
}
