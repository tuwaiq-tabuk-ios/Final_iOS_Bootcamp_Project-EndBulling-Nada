//
//  ListOfDoctoresViewController.swift
//  catchBullying
//
//  Created by apple on 15/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

class DoctorsListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var data : [DoctorModel] = []
  
  var currentDescription: String = ""
  var selectedProfile: DoctorModel?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    dismissKeyboard()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "doctorDetails" {
      if let detailsVC = segue.destination as? DoctorProfileDetailsViewController {
        detailsVC.selectedProfile = selectedProfile
      }
    }
  }
  
  private func fetchData() {
    data.removeAll()
    let db = Firestore.firestore()
    db.collection("doctors").getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      if let docs = snapshot?.documents {
        docs.forEach { doc in
          do {
            try self.data.append(doc.data(as: DoctorModel.self)!)
          } catch {
            fatalError(error.localizedDescription)
          }
        }
        self.tableView.reloadData()
      }
    }
  }
  
}

extension DoctorsListViewController : UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! DoctorsListCell
    //let data = data[indexPath.row]
    cell.listTableViewCell(name: data[indexPath.row].firstName, email: "email", zoom: "zoom")
    //
    //   cell.textLabel?.text = arryListOfDoctores[indexPath.row].name
    //   cell.textLabel?.text = arryListOfDoctores[indexPath.row].emil
    //   cell.textLabel?.text = arryListOfDoctores[indexPath.row].zoom
    //cell.imageView?.image = data[indexPath.row].image
    //cell.textLabel?.text = data[indexPath.row].firstName
    //cell.imageViewDoctor.layer.cornerRadius = cell.imageViewDoctor.frame.width/2
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
    selectedProfile = data[indexPath.row]
    self.performSegue(withIdentifier: "doctorDetails", sender: self)
  }
  
  //
  
  //
  //  private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //    tableView.deselectRow(at: indexPath, animated: true)
  //    self.performSegue(withIdentifier: "ListDetail", sender: nil)
  //
  //}
  
  
  
}
