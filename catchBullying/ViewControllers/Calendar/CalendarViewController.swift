//
//  CalendarViewController.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class CalendarViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  
  var appointments: [AppointmentModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchDate()
  }
  
  func fetchDate() {
    print("fetch")
    //load from firestore where id = user.id
    appointments.removeAll()
    let db = Firestore.firestore()
    db.collection("appointments").whereField(user.isDoctor ? "doctorID" : "patientID", isEqualTo: user.id).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      guard let docs = snapshot?.documents else { return }
      print(docs.count)
      for doc in docs {
        do {
          try self.appointments.append(doc.data(as: AppointmentModel.self)!)
        } catch {
          fatalError(error.localizedDescription)
        }
      }
      self.tableView.reloadData()
    }
    
  }
  
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    appointments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarCell
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    cell.nameLabel.text = user.isDoctor ? appointments[indexPath.row].patientName : appointments[indexPath.row].doctorName
    cell.dateLabel.text = dateFormatter.string(from: appointments[indexPath.row].date)
    return cell
  }
  
}
