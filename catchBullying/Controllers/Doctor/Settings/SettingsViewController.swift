//
//  SettingViewController.swift
//  catchBullying
//
//  Created by apple on 25/05/1443 AH.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
  @IBOutlet weak var tabelView: UITableView!
  
  var  data : [[ProfileCell]] = [
    [
    ProfileCell(title: "Information", icon: "person", color: .systemBlue),
    ProfileCell(title: "Change Email", icon:"envelope", color: .systemBlue),
    ProfileCell(title: "Change Password", icon:"lock.rectangle.fill", color: .systemBlue),
    ProfileCell(title: "Change Language", icon:"textformat.size.smaller.ja", color: .systemBlue)
  ],
  [
    ProfileCell(title: "Logout", icon: "power", color: .systemRed),
    ProfileCell(title: "Delete Account",           icon: "trash.square", color: .red)
  ]
]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // MARK: - Properties
    tabelView.delegate = self
    tabelView.dataSource = self
   
  }
  
  
 
  
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
        self.present(controller, animated: false, completion: nil)
      }
    }
  }
  
  // MARK: - Methods
  private func deleteAppointments(field: String, id: String ,completion: @escaping () -> ()) {
    var total: Int = 0
    var deleted: Int = 0
    
    FirestoreRepository.shared.read(collection: K.Collections.doctors,
                             field: field, value: id) { (items: [Appointment]) in
      if items.count == 0 {
        completion()
        return
      }
      total = items.count
      for item in items {
        FirestoreRepository.shared.delete(collection: K.Collections.doctors,
                                   documentID: item.docID!) {
          deleted += 1
          if total == deleted {
            completion()
          }
        }
      }
    }
  }
  
  private func deleteAccount() {
    self.startLoading()
    
    let profileFolder: String = user.isDoctor ? K.Collections.doctors : K.Collections.patients
    let profileDocID: String = user.isDoctor ? doctorProfile.docID! : patientProfile.docID!
    let field: String = user.isDoctor ? "doctorID" : "patientID"
    
    FirestoreRepository.shared.delete(collection: K.Collections.users, documentID: user.docID!) {
      FirestoreRepository.shared.delete(collection: profileFolder, documentID: profileDocID) {
        self.deleteAppointments(field: field, id: user.id) {
          Auth.auth().currentUser?.delete(completion: { error in
            if let error = error { fatalError() }
            else {
              self.stopLoading()
            }
          })
        }
      }
    }
  }
}


// MARK: - Table   Delegate, Datasource
extension SettingsViewController : UITableViewDelegate , UITableViewDataSource {
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    data.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
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
      self.performSegue(withIdentifier: K.Segues.go_to_InformationViewController, sender: nil)
    case "Change Email":
      self.performSegue(withIdentifier: K.Segues.go_to_ChangeEmailViewController, sender: nil)
    case "Change Password":
      self.performSegue(withIdentifier: K.Segues.go_to_ChangePasswordViewController, sender: nil)
    case "Change Language":
      let url = URL(string: UIApplication.openSettingsURLString)!
      UIApplication.shared.open(url)
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
