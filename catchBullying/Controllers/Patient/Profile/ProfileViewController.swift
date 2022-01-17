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
  
  
  // MARK: - Properties
  private var deleting: Bool = false
  
  let data: [[ProfileCellModel]] = [
    [
      ProfileCellModel(title: "Information",                            icon: "person",
                       
                       color: .systemBlue),
      ProfileCellModel(title: "Manage My Profile",          icon: "person.crop.circle.badge.checkmark.fill",                     color: .systemBlue),
      ProfileCellModel(title: "Change Email",            icon: "envelope",                                    color: .systemBlue),
      ProfileCellModel(title: "Change Password",            icon: "lock.rectangle.fill",                                    color: .systemBlue)
    ],
    [
      
      ProfileCellModel(title: "Important Numbers for You",  icon: "phone",                                                   color: .systemBlue)
      ,
      ProfileCellModel(title: "Change Language",            icon: "textformat.size.larger.ja",                                    color: .systemBlue)
    ],
    [
      ProfileCellModel(title: "Logout",                     icon: "power", color: .systemRed),
      ProfileCellModel(title: "Delete Account",           icon: "trash.square", color: .red)
    ]
    
  ]
  
  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  
  
  
  
  // MARK: - View controller lifecycle
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
  
  
  // MARK: - Methods
  private func deleteAppointments(field: String, id: String ,completion: @escaping () -> ()) {
    let db = Firestore.firestore()
    var total: Int = 0
    var deleted: Int = 0
    
    FirestoreRepository.shared.read(collection: "appointments", field: field, value: id) { (items: [AppointmentModel]) in
      if items.count == 0 {
        completion()
        return
      }
      total = items.count
      for item in items {
        FirestoreRepository.shared.delete(collection: "appointments", documentID: item.docID!) {
          deleted += 1
          if total == deleted {
            completion()
          }
        }
      }
    }
  }
  
  private func deleteAccount() {
    if deleting { return }
    deleting = true
    
    let profileFolder: String = user.isDoctor ? "doctors" : "patients"
    let profileDocID: String = user.isDoctor ? doctorProfile.docID! : patientProfile.docID!
    let field: String = user.isDoctor ? "doctorID" : "patientID"
    
    FirestoreRepository.shared.delete(collection: "users", documentID: user.docID!) {
      FirestoreRepository.shared.delete(collection: profileFolder, documentID: profileDocID) {
        self.deleteAppointments(field: field, id: user.id) {
          Auth.auth().currentUser?.delete(completion: { error in
            if let error = error { fatalError() }
            else {
              self.deleting = false
            }
          })
        }
      }
    }
  }
}


// MARK: - Table   Delegate, Datasource
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
