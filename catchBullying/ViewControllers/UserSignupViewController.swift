//
//  UserSignupViewController.swift
//  catchBullying
//
//  Created by apple on 11/05/1443 AH.
//

import UIKit
import FirebaseAuth

class UserSignupViewController: UIViewController {
  
  @IBOutlet weak var nicknameTextField: UITextField!
  @IBOutlet weak var emailAddressTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordText: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  var errorMessage: String = ""
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    passwordTextField.isSecureTextEntry = true
    confirmPasswordText.isSecureTextEntry = true
    
  }
  
  
  
  @IBAction func signUpButton(_ sender: Any) {
    
    if !validateForm(){
    
//
//      Auth.auth().createUser(withEmail: emailAddressTextField.text!, password: passwordTextField.text!) { authResult, error in
//        if let error = error {
//          if let errCode = AuthErrorCode(rawValue: error._code) {
//            switch errCode {
//            case .wrongPassword:
//              self.errorLabel.text = "wrongPassword"
//            case .userNotFound:
//              self.errorLabel.text = "userNotFound"
//            case .invalidEmail:
//              self.errorLabel.text = "invalidEmail"
//            default:
//              self.errorLabel.text = "Error: \(errCode.rawValue)"
//            }
//          }
//          return
//        }
//        print("user created")
//        // seague to questions
//        self.performSegue(withIdentifier: "userSignupToQuestions", sender: nil)
//      }
//
    }
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "UserQuestion")
    navigationController?.pushViewController(vc!, animated: true)
    
  }
  
  
  func validateForm() ->Bool {
    if nicknameTextField.text!.isEmpty {
      errorLabel.text = "Nickname is Missing!"
      return false
      
    }
    if emailAddressTextField.text!.isEmpty {
      errorLabel.text = "Email Addressis Missing!"
      return false
    }
    
    if passwordTextField.text!.isEmpty {
      errorLabel.text = "Password Missing!"
      return false
    }
    
    if confirmPasswordText.text!.isEmpty {
      errorLabel.text = "Password Confirmation Missing!"
      return false
    }
    
    if passwordTextField.text!.count < 8 {
      errorLabel.text = "Password too short!"
      return false
    }
    
    if passwordTextField.text != confirmPasswordText.text {
      errorLabel.text = "Password Does Not Match"
      return false
    }
    if !emailAddressTextField.text!.contains("@") {
      errorLabel.text = "Email invalid"
      return false
    }
    errorLabel.text = ""
    return true
    
  }
  
}

