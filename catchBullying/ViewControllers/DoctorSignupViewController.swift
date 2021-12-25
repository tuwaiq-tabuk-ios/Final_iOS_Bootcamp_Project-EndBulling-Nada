//
//  DoctorSignupViewController.swift
//  catchBullying
//
//  Created by apple on 11/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

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
        let doctor = DoctorModel(id: authResult!.user.uid,
                                 firstName: self.firstNameTextField.text!,
                                 lastName: self.lastNameTextField.text!,
                                 email: self.emailTextField.text!)
        
        let db = Firestore.firestore()
        do {
          _ = try db.collection("doctors").addDocument(from: doctor) { error in
            if let error = error {
              print(error.localizedDescription)
              return
            }
            
            //
            self.performSegue(withIdentifier: "doctorSignupToQuestions", sender: nil)
          }
        } catch {
          print(error.localizedDescription)
        }
        
        
        
      }

    }
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
