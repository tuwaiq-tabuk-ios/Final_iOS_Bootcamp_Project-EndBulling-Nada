//
//  CalendarViewController.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import UIKit

class DoctorAvailableDatesViewController: UIViewController {
  
  
  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - View controller lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    fetchData()
  }
  
  func fetchData() {
    self.startLoading()
    FirestoreRepository.shared.read(collection: K.Collections.doctors,
                             documentID: doctorProfile.docID!) { (item: Doctor) in
      doctorProfile = item
      self.tableView.reloadData()
      self.stopLoading()
    }
  }
  
  func saveData() {
    FirestoreRepository.shared.update(collection: K.Collections.doctors,
                               documentID: doctorProfile.docID!,
                               document: doctorProfile) {
    }
  }
  
  
  // MARK: - IBOutlets
  @IBAction func newDatePressed(_ sender: Any) {
    performSegue(withIdentifier:  K.Segues.go_to_DateSelectorViewController, sender: self)
  }
  
}


// MARK: - Table Delegate , DataSource
extension DoctorAvailableDatesViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return doctorProfile.availableDates.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    
    cell.textLabel?.text = dateFormatter.string(from: doctorProfile.availableDates[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.beginUpdates()
      doctorProfile.availableDates.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      saveData()
      tableView.endUpdates()
    }
  }

  
}

