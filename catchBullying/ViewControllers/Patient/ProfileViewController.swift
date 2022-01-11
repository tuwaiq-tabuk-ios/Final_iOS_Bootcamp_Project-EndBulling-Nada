//
//  ProFileViewController.swift
//  catchBullying
//
//  Created by apple on 15/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController {
  
  private var deleting: Bool = false
  
  let data: [[ProfileCellModel]] = [
    [
      ProfileCellModel(title: "Information",                            icon: "person",
                       
                       color: .systemBlue),
      ProfileCellModel(title: "Manage My Profile",          icon: "person.crop.circle.badge.checkmark.fill",                     color: .systemBlue),
      ProfileCellModel(title: "Change Email",            icon: "envelope",                                    color: .systemBlue),
      ProfileCellModel(title: "Change Password",            icon: "lock.rectangle.fill",                                    color: .systemBlue),
      ProfileCellModel(title: "Change Language",            icon: "textformat.size.larger.ja",                                    color: .systemBlue)
    ],
    [
      ProfileCellModel(title: "Contact Customer Service",   icon: "bubble.left.and.bubble.right", color: .systemBlue),
      ProfileCellModel(title: "Important Numbers for You",  icon: "phone",                                                   color: .systemBlue),
      ProfileCellModel(title: "Logout",                     icon: "power", color: .systemRed)
    ],
    [
      ProfileCellModel(title: "Delete Account",           icon: "trash.square", color: .red)
    ]
    
  ]
  
  @IBOutlet weak var tableView: UITableView!
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
 

    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    tableView.backgroundColor = .clear
    tableView.layer.masksToBounds = false
    tableView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
    tableView.layer.shadowOpacity = 1 // any value you want
    tableView.layer.shadowRadius = 100 // any value you want
    tableView.layer.shadowOffset = .init(width: 0, height: 10)
    
  }
  
  private func deleteAppointments(field: String, id: String ,completion: @escaping () -> ()) {
    let db = Firestore.firestore()
    var total: Int = 0
    var deleted: Int = 0
    db.collection("appointments").whereField(field, isEqualTo: id).getDocuments { snapshot, error in
      if let error = error { fatalError() }
      else {
        print(snapshot?.documents.count)
        guard let docs = snapshot?.documents else {
          completion()
          return
        }
        if docs.count == 0 {
          completion()
          return
        }
        total = docs.count
        for doc in docs {
          db.collection("appointments").document(doc.documentID).delete { error in
            deleted += 1
            if total == deleted {
              completion()
            }
          }
        }
      }
    }
  }
  
  private func deleteAccount() {
    if deleting { return }
    deleting = true
    print("delete account")
    // delete user file
    // delete profile file
    // delete appointments
    // delete account
    
    let profileFolder: String = user.isDoctor ? "doctors" : "patients"
    let profileDocID: String = user.isDoctor ? doctorProfile.docID! : patientProfile.docID!
    let field: String = user.isDoctor ? "doctorID" : "patientID"

    let db = Firestore.firestore()
    db.collection("users").document(user.docID!).delete { error in
      if let error = error { fatalError() }
      else {
        print("d users")
        db.collection(profileFolder).document(profileDocID).delete { error in
          if let error = error { fatalError() }
          else {
            print("d profile")
            self.deleteAppointments(field: field, id: user.id) {
              Auth.auth().currentUser?.delete(completion: { error in
                if let error = error { fatalError() }
                else {
                  print("d account")
                  self.deleting = false
                }
              })
            }
          }
        }
      }
    }
    
    
  }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    data.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    data[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.imageView?.image = UIImage(systemName: data[indexPath.section][indexPath.row].icon)
    cell.textLabel?.text = NSLocalizedString(data[indexPath.section][indexPath.row].title, comment: "")
    cell.textLabel?.textColor = data[indexPath.section][indexPath.row].color
    return cell
  }
  
  //  [
  //    ProfileCellModel(title: "Information",                            icon: "person",
  //
  //                     color: .black),
  //    ProfileCellModel(title: "Manage My Profile",          icon: "person.crop.circle.badge.checkmark.fill",                     color: .black),
  //    ProfileCellModel(title: "Change Language",            icon: "Editor placeholder in source file",                                    color: .black)
  //  ],
  //  [
  //    ProfileCellModel(title: "Contact Customer Service",   icon: "person", color: .black),
  //    ProfileCellModel(title: "Important Numbers for You",  icon: "phone",                                                   color: .black),
  //    ProfileCellModel(title: "Logout",                     icon: "power", color: .black)
  //  ],
  //  [
  //    ProfileCellModel(title: "Delete Account",           icon: "delete", color: .red)
  //  ]
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    switch data[indexPath.section][indexPath.row].title {
    case "Information":
      self.performSegue(withIdentifier: "information", sender: nil)
    case "Manage My Profile":
      self.performSegue(withIdentifier: "PatientToQuestions", sender: nil)
    case "Change Email":
      self.performSegue(withIdentifier: "ChangeEmail", sender: nil)
    case "Change Password":
      self.performSegue(withIdentifier: "ChangePassword", sender: nil)
    case "Change Language":
      let url = URL(string: UIApplication.openSettingsURLString)!
      UIApplication.shared.open(url)
    case "Contact Customer Service":
      print("Contact Customer Service")
    case "Important Numbers for You":
      self.performSegue(withIdentifier: "phone", sender: nil)
    case "Logout":
      do {
        try Auth.auth().signOut()
      } catch {
        print(error.localizedDescription)
      }
    case "Delete Account":
      deleteAccount()
    default: fatalError()
    }
    
    
    
  }
  
}
