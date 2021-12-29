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
  
  var user: UserModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
            try self.user = docs.first!.data(as: UserModel.self)
            print("done", self.user.email)
            
            if self.user.isDoctor {
              self.performSegue(withIdentifier: "landingToDoctorHome", sender: nil)
            } else {
              self.performSegue(withIdentifier: "landingToUserHome", sender: nil)
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
