//
//  LoginViewController.swift
//  catchBullying
//
//  Created by apple on 10/05/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  
  // MARK: - IBOutlets
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
  
  // MARK: - IBAction
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
  
  @IBAction func LoginButtonPressed(_ sender: UIButton) {
    if !validate() {
      return
    }
    self.startLoading()
    AuthRepository.shared.signIn(email: emailField.text!, password: passwordField.text!) { error, usr in
      if let error = error {
        self.errorLabel.text = NSLocalizedString(error, comment: "") 
        self.stopLoading()
        return
      } else {
        guard let usr = usr else { return }
        
        FirestoreRepository.shared.read(collection: K.collections.users.rawValue, field: "id", value: usr.uid) { (doc: UserModel?) in
          user = doc
          if user.isDoctor {
            FirestoreRepository.shared.read(collection: K.collections.doctors.rawValue, field: "id", value: user.id) { (doc: DoctorModel?) in
              doctorProfile = doc
              self.stopLoading()
              let controller = self.storyboard?.instantiateViewController(identifier: "DoctorHomeVC") as! DoctorHomeTabBarController
              controller.modalPresentationStyle = .fullScreen
              controller.modalTransitionStyle = .flipHorizontal
              self.present(controller, animated: false, completion: nil)
            }
          } else {
            FirestoreRepository.shared.read(collection: K.collections.patients.rawValue, field: "id", value: user.id) { (doc: PatientModel?) in
              patientProfile = doc
              self.stopLoading()
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
}
