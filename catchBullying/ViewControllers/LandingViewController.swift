//
//  LandingViewController.swift
//  catchBullying
//
//  Created by apple on 10/05/1443 AH.
//

import UIKit
import FirebaseAuth

class LandingViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //try! Auth.auth().signOut()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
   

    
    
    if let usr = Auth.auth().currentUser {
      
      FirestoreRepository.read(collection: "users", field: "id", value: usr.uid) { (doc: UserModel) in
        user = doc
        if user.isDoctor {
          FirestoreRepository.read(collection: "doctors", field: "id", value: user.id) { (doc: DoctorModel) in
            doctorProfile = doc
            let controller = self.storyboard?.instantiateViewController(identifier: "DoctorHomeVC") as! DoctorHomeTabBarController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self.present(controller, animated: false, completion: nil)
          }
        } else {
          FirestoreRepository.read(collection: "patients", field: "id", value: user.id) { (doc: PatientModel) in
            patientProfile = doc
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
