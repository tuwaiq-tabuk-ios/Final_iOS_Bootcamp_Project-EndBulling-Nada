//
//  UserSignupViewController.swift
//  catchBullying
//
//  Created by apple on 11/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class UserSignupViewController: UIViewController {
  
  @IBOutlet weak var nicknameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
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
    
    if validateForm() {
    

      Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
        if let error = error {
          if let errCode = AuthErrorCode(rawValue: error._code) {
            switch errCode {
            case .emailAlreadyInUse:
              self.errorLabel.text = "emailAlreadyInUse"
            case .wrongPassword:
              self.errorLabel.text = "wrongPassword"
            case .userNotFound:
              self.errorLabel.text = "userNotFound"
            case .invalidEmail:
              self.errorLabel.text = "invalidEmail"
            default:
              self.errorLabel.text = "Error: \(errCode.rawValue)"
            }
          }
          return
        }
        print("user created")
        // create user file in firestore
        // seague to questions
        let user = UserModel(id: authResult!.user.uid, nickName: self.nicknameTextField.text!, email: self.emailTextField.text!)
        
        let db = Firestore.firestore()
        do {
          try db.collection("users").addDocument(from: user) { error in
            if let error = error {
              print(error.localizedDescription)
              return
            }
            
            //
            self.performSegue(withIdentifier: "userSignupToQuestions", sender: nil)
          }
        } catch {
          print(error.localizedDescription)
        }
        
        
        
      }

    }
    
  }
  
  
  func validateForm() ->Bool {
    if nicknameTextField.text!.isEmpty {
      errorLabel.text = "Nickname is Missing!"
      return false
      
    }
    if emailTextField.text!.isEmpty {
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
    if !emailTextField.text!.contains("@") {
      errorLabel.text = "Email invalid"
      return false
    }
    errorLabel.text = ""
    return true
    
  }
  
}

