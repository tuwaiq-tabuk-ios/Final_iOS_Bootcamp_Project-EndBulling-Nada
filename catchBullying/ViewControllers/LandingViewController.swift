//
//  LandingViewController.swift
//  catchBullying
//
//  Created by apple on 10/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class LandingViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //try! Auth.auth().signOut()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    
    
    if let usr = Auth.auth().currentUser {
      
      let db = Firestore.firestore()
      
      db.collection("users").whereField("id", isEqualTo: usr.uid).getDocuments { snapshot, error in
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        if let docs = snapshot?.documents {
          do {
            try user = docs.first!.data(as: UserModel.self)
            print("done", user.email)
            
            if user.isDoctor {
              
              db.collection("doctors").whereField("id", isEqualTo: user.id).getDocuments { snapshot, error in
                if let error = error {
                  fatalError()
                }
                
                if let docs = snapshot?.documents {
                  do {
                    try doctorProfile = docs.first!.data(as: DoctorModel.self)
                    let controller = self.storyboard?.instantiateViewController(identifier: "DoctorHomeVC") as! DoctorHomeViewController
                    controller.modalPresentationStyle = .fullScreen
                    controller.modalTransitionStyle = .flipHorizontal
                    self.present(controller, animated: false, completion: nil)
                  } catch {
                    fatalError()
                  }
                }
              }
              
            } else {
              
              db.collection("patients").whereField("id", isEqualTo: user.id).getDocuments { snapshot, error in
                if let error = error {
                  fatalError()
                }
                
                if let docs = snapshot?.documents {
                  do {
                    try patientProfile = docs.first!.data(as: PatientModel.self)
                    let controller = self.storyboard?.instantiateViewController(identifier: "UserHomeVC") as! UserHomeViewController
                    controller.modalPresentationStyle = .fullScreen
                    controller.modalTransitionStyle = .flipHorizontal
                    self.present(controller, animated: false, completion: nil)
                  } catch {
                    fatalError()
                  }
                }
              }
            }
            
            
            // seague
          } catch {
            print(error.localizedDescription)
          }
        }
      }
      print("already logged in")
      
    }
  }
  
  
}
