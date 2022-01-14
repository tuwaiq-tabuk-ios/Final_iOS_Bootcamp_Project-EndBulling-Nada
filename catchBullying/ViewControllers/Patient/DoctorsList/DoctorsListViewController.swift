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
    
    FirestoreRepository.read(collection: "doctors") { (items: [DoctorModel]) in
      self.data = items
      self.tableView.reloadData()
    }
  }
  
}

extension DoctorsListViewController : UITableViewDelegate , UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! DoctorsListCell
    cell.listTableViewCell(name: data[indexPath.row].firstName, email: "email", zoom: "zoom")
    cell.imageViewDoctor.layer.cornerRadius = cell.imageViewDoctor.frame.width/2
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedProfile = data[indexPath.row]
    self.performSegue(withIdentifier: "doctorDetails", sender: self)
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    data.swapAt(sourceIndexPath.row, destinationIndexPath.row)
  }
 
}
