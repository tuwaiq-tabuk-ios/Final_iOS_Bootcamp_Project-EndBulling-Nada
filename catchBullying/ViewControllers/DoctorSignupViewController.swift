//
//  DoctorSignupViewController.swift
//  catchBullying
//
//  Created by apple on 11/05/1443 AH.
//

import UIKit
import FirebaseAuth

class DoctorSignupViewController: UIViewController {
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmationTextField: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  var errorMessage: String = ""
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    passwordTextField.isSecureTextEntry = true
    confirmationTextField.isSecureTextEntry = true

    }
  
  @IBAction func signup(_ sender: Any) {
    if !validateForm() {
      errorLabel.text = errorMessage
      return
    }
    let vc = storyboard?.instantiateViewController(withIdentifier: "Questions")
    navigationController?.pushViewController(vc!, animated: true)
  }
  
  func validateForm() -> Bool {
    if firstNameTextField.text!.isEmpty {
      errorMessage = "First Name Missing!"
      return false
    }
    if lastNameTextField.text!.isEmpty {
      errorMessage = "Last Name Missing!"
      return false
    }
    if emailTextField.text!.isEmpty {
      errorMessage = "Email Missing!"
      return false
    }
    if passwordTextField.text!.isEmpty {
      errorMessage = "Password Missing!"
      return false
    }
    if confirmationTextField.text!.isEmpty {
      errorMessage = "Password Confirmation Missing!"
      return false
    }
    if passwordTextField.text!.count < 8 {
      errorMessage = "Password too short!"
      return false
    }
    if passwordTextField.text != confirmationTextField.text {
      errorMessage = "Password Does Not Match"
      return false
    }
    if !emailTextField.text!.contains("@") {
      errorMessage = "Email invalid"
      return false
    }
    errorMessage = ""
    return true
  }
  
}
