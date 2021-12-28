//
//  DoctorProfileViewController.swift
//  catchBullying
//
//  Created by apple on 21/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase

class DoctorProfileViewController: UIViewController {

  

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var informationsLabel: UILabel!
  @IBOutlet weak var languageLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var experienceLabel: UILabel!
  @IBOutlet weak var zoomLabel: UILabel!
  
  
  

  @IBAction func languageButton(_ sender: Any) {
  }
  
  @IBAction func logoffButton(_ sender: Any) {
    
  
      Auth.auth().addStateDidChangeListener { auth, user in
        if let doctor = user {
            print("User is signed in.")
        } else {
            print("User is signed out.")
          let controller = self.storyboard?.instantiateViewController(identifier: "MainVC") as! UINavigationController
          controller.modalPresentationStyle = .fullScreen
          controller.modalTransitionStyle = .flipHorizontal
          //UserDefaults.standard.hasOnboarded = true
          self.present(controller, animated: false, completion: nil)
        }
      }
    }
    
  
  
  
  @IBAction func deleteAccount(_ sender: Any) {
  }
  
  
}
