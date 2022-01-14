//
//  AppointmentSelectorViewController.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class AppointmentSelectorViewController: UIViewController {
  
  var selectedProfile: DoctorModel?
  
  @IBOutlet weak var tabelView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    tabelView.delegate = self
    tabelView.dataSource = self
    }
}

extension AppointmentSelectorViewController : UITableViewDelegate , UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectedProfile!.availableDates.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    cell.textLabel?.text = dateFormatter.string(from: selectedProfile!.availableDates[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    // create appointment
    let appointment = AppointmentModel(patientID: patientProfile.id, patientName: patientProfile.nickname,
                                       doctorID: selectedProfile!.id,doctorName: selectedProfile!.fullName,
                                       date: selectedProfile!.availableDates[indexPath.row],
                                       zoom: false
    )
    
    let db = Firestore.firestore()
    do {
      _ = try db.collection("appointments").addDocument(from: appointment) { error in
        if let error = error {
          fatalError(error.localizedDescription)
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
      }
    } catch {
      fatalError(error.localizedDescription)
    }
    
  }
  
  
}

