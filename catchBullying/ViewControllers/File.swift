////
////  File.swift
////  catchBullying
////
////  Created by apple on 23/05/1443 AH.
////
//
//import Foundation
//import UIKit
//import Firebase
//import FirebaseFirestore
//
//
//class ProfileVC: UIViewController {
//  
//  @IBOutlet weak var imageLog: UIImageView!
//  @IBOutlet weak var nameLabel: UILabel!
//  @IBOutlet weak var emailLabel: UILabel!
//  @IBOutlet weak var PhoneLabel: UILabel!
//  @IBOutlet weak var idLabel: UILabel!
//  
//  var boos = [Boos]()
//  var employee = [Employee]()
//  let db = Firestore.firestore()
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
////    conerReduis()
//    readUsers()
//  }
//  
//  
//  func readUsers(){
//    if  let user = Auth.auth().currentUser?.uid{
//      let docRef = db.collection("Users").document(user)
//      
//      docRef.getDocument { (document, error) in
//        if let document = document, document.exists {
//          let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//          self.nameLabel.text = document.data()?["name"] as? String
//          self.emailLabel.text = document.data()?["email"] as? String
//          self.PhoneLabel.text = document.data()?["phone"] as? String
//          self.idLabel.text = document.data()?["id"] as? String
//          _ = Employee(name: self.nameLabel.text!, email: self.emailLabel.text!, phone: self.PhoneLabel.text!, id: self.idLabel.text!,task: "",evaluation: "")
//          print("Document data")
//        } else {
//          print("Document does not exist\(error?.localizedDescription)")
//        }
//      }
//      
//    }
//  }
//  
//}
