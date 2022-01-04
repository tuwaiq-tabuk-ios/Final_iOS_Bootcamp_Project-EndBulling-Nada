//
//  SettingViewController.swift
//  catchBullying
//
//  Created by apple on 25/05/1443 AH.
//

import UIKit
import FirebaseAuth

class SettingViewController: UIViewController {
  @IBOutlet weak var tabelView: UITableView!
  
  var  data : [ProfileCellModel] = [
    ProfileCellModel(title: "Information", icon: "person", color: .blue),
    ProfileCellModel(title: "Manage My Profile", icon: "person", color: .black),
    ProfileCellModel(title: "Change Language", icon:"textformat.size.smaller.ja", color: .black),
    ProfileCellModel(title: "Logout", icon: "person", color: .red),
    ProfileCellModel(title: "Delete Account", icon: "person", color: .red)
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
        //UserDefaults.standard.hasOnboarded = true
        self.present(controller, animated: false, completion: nil)
      }
    }
  }
  
  
  
  
}

extension SettingViewController : UITableViewDelegate , UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.imageView?.image = UIImage(systemName: data[indexPath.row].icon)
    cell.textLabel?.text = data[indexPath.row].title
    cell.textLabel?.textColor = data[indexPath.row].color
    
    return cell
  }
  
//  ProfileCellModel(title: "Information", icon: "person", color: .blue),
//  ProfileCellModel(title: "Manage My Profile", icon: "person", color: .black),
//  ProfileCellModel(title: "Change Language", icon:"textformat.size.smaller.ja", color: .black),
//  ProfileCellModel(title: "Logout", icon: "person", color: .red),
//  ProfileCellModel(title: "Delete Account", icon: "person", color: .red)]
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    switch data[indexPath.row].title {
    case "Information":
      self.performSegue(withIdentifier: "information", sender: nil)
    case "Manage My Profile":
      self.performSegue(withIdentifier: "DoctorToQuestions", sender: nil)
    case "Change Language":
      print("change language")
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
      print("delete account")
    default: fatalError()
    }
  }
  
  
}
