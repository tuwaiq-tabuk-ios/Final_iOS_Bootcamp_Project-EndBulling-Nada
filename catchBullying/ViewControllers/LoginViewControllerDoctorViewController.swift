//
//  LoginViewControllerDoctorViewController.swift
//  catchBullying
//
//  Created by apple on 16/05/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginViewControllerDoctorViewController: UIViewController {

  @IBOutlet weak var emailField: MainTF!
  @IBOutlet weak var passwordField: MainTF!
  @IBOutlet weak var errorLabel: UILabel!
  
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }
  func validate() -> Bool {
    if !emailField.text!.contains("@") {
      errorLabel.text = "Email invalid"
      return false
    }
    if emailField.text!.count < 4 {
      errorLabel.text = "Email too short"
      return false
    }
    return true
  }
    
  @IBAction func loginButton(_ sender: Any) {
    if !validate() {
      return
    }
  let vc = storyboard?.instantiateViewController(withIdentifier:"Doctors")
    navigationController?.pushViewController(vc!, animated: true)
    
    
    Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
      if let error = error {
        if let errCode = AuthErrorCode(rawValue: error._code) {
          switch errCode {
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
      print("LOGGED IN")
      
      
      
      
    
  }
  
}
}
