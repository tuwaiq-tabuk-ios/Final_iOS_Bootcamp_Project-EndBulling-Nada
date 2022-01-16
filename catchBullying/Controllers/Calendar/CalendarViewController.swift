//
//  CalendarViewController.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import UIKit

class CalendarViewController: UIViewController {
  
  
  // MARK: - IBOutlets
  @IBOutlet var tableView: UITableView!
  
  // MARK: - Properties
  var appointments: [AppointmentModel] = []
  

  
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
  
  
  // MARK: - Methods
  func fetchData() {
    appointments.removeAll()
    FirestoreRepository.read(collection: "appointments",
                             field: user.isDoctor ? "doctorID" : "patientID",
                             value: user.id) { (items: [AppointmentModel]) in
      self.appointments = items
      self.appointments.sort { a1, a2 in
        return a1.date > a2.date
      }
      self.tableView.reloadData()
      if self.appointments.count > 0 {
        self.tabBarItem.badgeValue = "\(self.appointments.count)"
      }
      
    }
  }
}


// MARK: - Table data source
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
    dateFormatter.timeStyle = .short
    
    let appointment = appointments[indexPath.row]
    cell.nameLabel.text = user.isDoctor ? appointment.patientName : appointment.doctorName
    cell.dateLabel.text = dateFormatter.string(from: appointment.date)
    cell.zoomLabel.text = appointment.zoom ? "Zoom" : "Chat"
    
    return cell
  }
    
  
}
