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
  
  
  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  var data : [Doctor] = []
  
  var currentDescription: String = ""
  var selectedProfile: Doctor?
  
  
  
  // MARK: - View controller lifecycle
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
    if segue.identifier == K.Segues.go_to_DoctorProfileDetailsViewController {
      if let detailsVC = segue.destination as? DoctorProfileDetailsViewController {
        detailsVC.selectedProfile = selectedProfile
      }
    }
  }
  
  
  
  // MARK: - Methods
  private func fetchData() {
    self.startLoading()
    data.removeAll()
    
    FirestoreRepository.shared.read(collection: K.Collections.doctors) { (items: [Doctor]) in
      self.data = items
      self.tableView.reloadData()
      self.stopLoading()
    }
  }
  
}

// MARK: - Table Delegate, Data Source
extension DoctorsListViewController : UITableViewDelegate , UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! DoctorsListCell
    cell.listTableViewCell(name: data[indexPath.row].firstName, email: ""  , zoom: data[indexPath.row].zoom)
  
    cell.imageViewDoctor.layer.cornerRadius = cell.imageViewDoctor.frame.width/2
    
    
    if data[indexPath.row].imageURL != "" {
      cell.imageViewDoctor.load(url: URL(string: data[indexPath.row].imageURL)!)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedProfile = data[indexPath.row]
    self.performSegue(withIdentifier: K.Segues.go_to_DoctorProfileDetailsViewController, sender: self)
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    data.swapAt(sourceIndexPath.row, destinationIndexPath.row)
  }
 
}
