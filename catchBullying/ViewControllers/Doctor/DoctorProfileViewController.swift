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
  @IBOutlet weak var providesAdvice: UILabel!
  
  override func viewDidLoad() {

  }
  
  override func viewDidAppear(_ animated: Bool) {
    Auth.auth().addStateDidChangeListener { auth, user in
      if let user = user {
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
  
  

  
//  @IBAction func logoffButton(_ sender: Any) {
//    do {
//      try Auth.auth().signOut()
//    } catch {
//      print(error.localizedDescription)
//    }
//  }
//
//
  
  

  
  
}
