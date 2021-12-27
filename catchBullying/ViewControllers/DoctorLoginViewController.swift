//
//  LoginViewControllerDoctorViewController.swift
//  catchBullying
//
//  Created by apple on 16/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class DoctorLoginViewController: UIViewController {
  
  @IBOutlet weak var emailField: MainTF!
  @IBOutlet weak var passwordField: MainTF!
  @IBOutlet weak var errorLabel: UILabel!
  
  var doctor: DoctorModel!
  
  
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
  
  @IBAction func loginButton(_ sender: UIButton) {
    
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
      
      db.collection("doctors").whereField("id", isEqualTo: authResult!.user.uid).getDocuments { snapshot, error in
        if let error = error {
          print(error.localizedDescription)
          sender.isEnabled = true
          return
        }
        
        if let docs = snapshot?.documents {
          do {
            try self.doctor = docs.first!.data(as: DoctorModel.self)
            print("done", self.doctor.email)
            
            self.performSegue(withIdentifier: "doctorHomeScreen", sender: nil)
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

