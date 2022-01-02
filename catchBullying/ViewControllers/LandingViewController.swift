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
            print(error.localizedDescription)
          }
        }
      }
      print("already logged in")
      
    }
  }
  
  
}
