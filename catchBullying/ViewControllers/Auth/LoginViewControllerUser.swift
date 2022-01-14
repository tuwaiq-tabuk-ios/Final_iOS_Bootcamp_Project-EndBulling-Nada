//
//  LoginViewController.swift
//  catchBullying
//
//  Created by apple on 10/05/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()


    self.dismissKeyboard()
  }
  
  func validate() -> Bool {
    if emailField.text!.isEmpty {
      errorLabel.text = "Missing Email"
      return false
    }
    if passwordField.text!.isEmpty {
      errorLabel.text = "Missing Password"
      return false
    }
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
  
  @IBAction func inputUser1(_ sender: Any) {
    emailField.text = "patient@patient.com"
    passwordField.text = "12345678"
  }
  @IBAction func inputUser2(_ sender: Any) {
    emailField.text = "patient1@patient.com"
    passwordField.text = "12345678"
  }
  @IBAction func inputUser3(_ sender: Any) {
    emailField.text = "patient2@patient.com"
    passwordField.text = "12345678"
  }
  
  @IBAction func inputDoctor1(_ sender: Any) {
    emailField.text = "doctor@doctor.com"
    passwordField.text = "12345678"
  }
  @IBAction func inputDoctor2(_ sender: Any) {
    emailField.text = "doctor1@doctor.com"
    passwordField.text = "12345678"
  }
  @IBAction func inputDoctor3(_ sender: Any) {
    emailField.text = "doctor2@doctor.com"
    passwordField.text = "12345678"
  }
  
  @IBAction func login(_ sender: UIButton) {
    sender.isEnabled = false
    if !validate() {
      sender.isEnabled = true
      return
    }
    
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
        sender.isEnabled = true
        return
      }
      
      FirestoreRepository.read(collection: "users", field: "id", value: authResult!.user.uid) { (doc: UserModel) in
        user = doc
        if user.isDoctor {
          FirestoreRepository.read(collection: "doctors", field: "id", value: user.id) { (doc: DoctorModel) in
            doctorProfile = doc
            sender.isEnabled = true
            let controller = self.storyboard?.instantiateViewController(identifier: "DoctorHomeVC") as! DoctorHomeTabBarController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self.present(controller, animated: false, completion: nil)
          }
        } else {
          FirestoreRepository.read(collection: "patients", field: "id", value: user.id) { (doc: PatientModel) in
            patientProfile = doc
            sender.isEnabled = true
            let controller = self.storyboard?.instantiateViewController(identifier: "UserHomeVC") as! PatientHomeTabBarController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self.present(controller, animated: false, completion: nil)
          }
        }
      }
    }
  }
}
