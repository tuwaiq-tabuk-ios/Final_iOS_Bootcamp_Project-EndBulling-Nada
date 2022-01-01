//
//  LoginViewController.swift
//  catchBullying
//
//  Created by apple on 10/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class LoginViewController: UIViewController {
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
  
  @IBAction func inputUser(_ sender: Any) {
    emailField.text = "patient@patient.com"
    passwordField.text = "12345678"
  }
  
  @IBAction func inputDoctor(_ sender: Any) {
    emailField.text = "doctor@doctor.com"
    passwordField.text = "112345678"
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
      
      print("LOGGED IN")
      
      let db = Firestore.firestore()
      
      db.collection("users").whereField("id", isEqualTo: authResult!.user.uid).getDocuments { snapshot, error in
        if let error = error {
          print(error.localizedDescription)
          sender.isEnabled = true
          return
        }
        
        if let docs = snapshot?.documents {
          do {
            try user = docs.first!.data(as: UserModel.self)
            print("done", user.email)
            
            if user.isDoctor {
//              self.performSegue(withIdentifier: "landingToDoctorHome", sender: nil)
              let controller = self.storyboard?.instantiateViewController(identifier: "DoctorHomeVC") as! DoctorHomeViewController
              controller.modalPresentationStyle = .fullScreen
              controller.modalTransitionStyle = .flipHorizontal
              //UserDefaults.standard.hasOnboarded = true
              self.present(controller, animated: false, completion: nil)
            } else {
//              self.performSegue(withIdentifier: "landingToUserHome", sender: nil)
              let controller = self.storyboard?.instantiateViewController(identifier: "UserHomeVC") as! UserHomeViewController
              controller.modalPresentationStyle = .fullScreen
              controller.modalTransitionStyle = .flipHorizontal
              //UserDefaults.standard.hasOnboarded = true
              self.present(controller, animated: false, completion: nil)
            }
            // seague
          } catch {
            sender.isEnabled = true
            print(error.localizedDescription)
          }
        }
      }
    }
  }
}
