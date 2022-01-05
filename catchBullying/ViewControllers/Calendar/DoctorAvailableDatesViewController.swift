//
//  CalendarViewController.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class DoctorAvailableDatesViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  
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
    let db = Firestore.firestore()
    db.collection("doctors").document(doctorProfile.docID!).getDocument { snapshot, error in
      if let error = error {
        fatalError()
      }
      do {
        try doctorProfile = snapshot?.data(as: DoctorModel.self)!
        self.tableView.reloadData()
      } catch {
        fatalError()
      }
    }
  }
  
  
  @IBAction func newDate(_ sender: Any) {
    performSegue(withIdentifier: "dateSelector", sender: self)
  }
  
}

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
    dateFormatter.timeStyle = .none
    
    cell.textLabel?.text = dateFormatter.string(from: doctorProfile.availableDates[indexPath.row])
    return cell
  }
  
}
