//
//  ProFileViewController.swift
//  catchBullying
//
//  Created by apple on 15/05/1443 AH.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
  
  let data: [[ProfileCellModel]] = [
    [
      ProfileCellModel(title: "Information",                            icon: "person",
                       
                       color: .systemBlue),
      ProfileCellModel(title: "Manage My Profile",          icon: "person.crop.circle.badge.checkmark.fill",                     color: .systemBlue),
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
    cell.textLabel?.text = data[indexPath.section][indexPath.row].title
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
      print("delete account")
    default: fatalError()
    }
    
    
    
  }
  
}
