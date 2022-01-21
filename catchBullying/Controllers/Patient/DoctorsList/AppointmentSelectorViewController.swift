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
  var booking: Bool = false
  
  
  
  //  MARK: - IBOutlet
  @IBOutlet weak var tabelView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    tabelView.delegate = self
    tabelView.dataSource = self
    }
}

// MARK: - Table   Delegate, Datasource


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
    dateFormatter.timeStyle = .short
    
    cell.textLabel?.text = dateFormatter.string(from: selectedProfile!.availableDates[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if booking { return }
    
    let alert = UIAlertController(title: "Appointment Type", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Zoom", style: .default, handler: { _ in
      self.createZoom(date: self.selectedProfile!.availableDates[indexPath.row])
    }))
    alert.addAction(UIAlertAction(title: "Chat", style: .default, handler: { _ in
      self.createChat(date: self.selectedProfile!.availableDates[indexPath.row])
    }))
    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
      alert.popoverPresentationController?.sourceView = view
      alert.popoverPresentationController?.sourceRect = view.bounds
      alert.popoverPresentationController?.permittedArrowDirections = .up
    default:
      break
    }
    self.present(alert, animated: true, completion: nil)
  }
  
  private func createZoom(date: Date) {
    booking = true
    let appointment = AppointmentModel(patientID: patientProfile.id, patientName: patientProfile.nickname,
                                       doctorID: selectedProfile!.id,doctorName: selectedProfile!.fullName,
                                       date: date,
                                       zoom: true
    )
    
    FirestoreRepository.shared.create(collection: K.collections.appointments.rawValue, document: appointment) { _ in
      self.booking = false
      self.dismiss(animated: true, completion: nil)
      
      //self.navigationController?.dismiss(animated: true, completion: nil)
    }
  }
  
  private func createChat(date: Date) {
    booking = true
    let appointment = AppointmentModel(patientID: patientProfile.id, patientName: patientProfile.nickname,
                                       doctorID: selectedProfile!.id,doctorName: selectedProfile!.fullName,
                                       date: date,
                                       zoom: false
    )
    
    FirestoreRepository.shared.create(collection:  K.collections.appointments.rawValue, document: appointment) { _ in
      self.booking = false
      self.dismiss(animated: true, completion: nil)
      //self.navigationController?.dismiss(animated: true, completion: nil)
    }
  }
  
  
}

