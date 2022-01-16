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
  
  private var deleting: Bool = false
  
  var  data : [ProfileCellModel] = [
    ProfileCellModel(title: "Information", icon: "person", color: .systemBlue),
    ProfileCellModel(title: "Change Email", icon:"envelope", color: .systemBlue),
    
    ProfileCellModel(title: "Change Password", icon:"lock.rectangle.fill", color: .systemBlue),
    ProfileCellModel(title: "Change Language", icon:"textformat.size.smaller.ja", color: .systemBlue),
    ProfileCellModel(title: "Logout", icon: "person", color: .systemRed),
    ProfileCellModel(title: "Delete Account", icon: "person", color: .systemRed)
  ]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    tabelView.delegate = self
    tabelView.dataSource = self
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
        self.present(controller, animated: false, completion: nil)
      }
    }
  }
  
  private func deleteAppointments(field: String, id: String ,completion: @escaping () -> ()) {
    var total: Int = 0
    var deleted: Int = 0
    
    FirestoreRepository.read(collection: "appointments",
                             field: field, value: id) { (items: [AppointmentModel]) in
      if items.count == 0 {
        completion()
        return
      }
      total = items.count
      for item in items {
        FirestoreRepository.delete(collection: "appointments",
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
    if deleting { return }
    deleting = true
    
    let profileFolder: String = user.isDoctor ? "doctors" : "patients"
    let profileDocID: String = user.isDoctor ? doctorProfile.docID! : patientProfile.docID!
    let field: String = user.isDoctor ? "doctorID" : "patientID"
    
    FirestoreRepository.delete(collection: "users", documentID: user.docID!) {
      FirestoreRepository.delete(collection: profileFolder, documentID: profileDocID) {
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








// MARK: - extension
extension SettingsViewController : UITableViewDelegate , UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.imageView?.image = UIImage(systemName: data[indexPath.row].icon)
    cell.textLabel?.text = NSLocalizedString(data[indexPath.row].title, comment: "") 
    cell.textLabel?.textColor = data[indexPath.row].color
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    switch data[indexPath.row].title {
    case "Information":
      self.performSegue(withIdentifier: "information", sender: nil)
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
